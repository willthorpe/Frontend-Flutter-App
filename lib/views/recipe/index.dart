import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';

class BookPage extends StatefulWidget {
  BookPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final _scaffoldBookKey = GlobalKey<ScaffoldState>();
  final _formBookKey = GlobalKey<FormState>();
  List<GlobalKey<ScaffoldState>> _scaffoldKeys = [];
  var _allResults = [];
  var _displayList = [];
  var _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldBookKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
            key: _formBookKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter recipe to search',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _searchTerm = value;
                        _displayList = [];
                        for (var i = 0; i < _allResults.length; i++) {
                          if (_allResults[i]['name'].contains(_searchTerm) ||
                              _searchTerm == '') {
                            _displayList.add(_allResults[i]);
                          }
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      future: fetchRecipes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (_allResults.length == 0) {
                            _displayList = snapshot.data;
                            _allResults = snapshot.data;
                          }
                          return new ListView.separated(
                            padding: EdgeInsets.all(10),
                            itemCount: _displayList.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(_displayList[index].toString());
                              _scaffoldKeys.add(GlobalKey<ScaffoldState>());
                              var totalTime = _displayList[index]['cookTime'] + _displayList[index]['prepTime'];
                              return new ListTile(
                                  key: _scaffoldKeys.last,
                                  leading: const Icon(Icons.restaurant_menu),
                                  title: Text(_displayList[index]['name']),
                                  subtitle: Text(_displayList[index]['tag']),
                                  trailing: Text(
                                      "Total time: ${totalTime.toString()}"),
                                  onTap: () {
                                    RenderBox box = _scaffoldKeys[index]
                                        .currentContext
                                        .findRenderObject();
                                    Offset position =
                                        box.localToGlobal(Offset.zero);
                                    showMenu(
                                        context: context,
                                        position: RelativeRect.fromLTRB(
                                            position.dx, position.dy, 0, 0),
                                        items: [
                                          PopupMenuItem(
                                              child: FlatButton(
                                            color: Colors.white,
                                            child: Text('View Recipe'),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/recipeview',
                                                  arguments: {
                                                    'title': _displayList[index]
                                                        ['name'],
                                                    'data': _displayList[index]
                                                  });
                                            },
                                          )),
                                          PopupMenuItem(
                                              child: FlatButton(
                                                color: Colors.white,
                                                child: Text('Edit Recipe'),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/editrecipe',
                                                      arguments: {
                                                        'title': _displayList[index]
                                                        ['name'],
                                                        'data': _displayList[index]
                                                      });
                                                },
                                              )),
                                        ]);
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                )
              ],
            )));
  }
}
