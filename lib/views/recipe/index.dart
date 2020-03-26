import 'package:flutter/material.dart';
import '../../http/fetch.dart';

class BookPage extends StatefulWidget {
  BookPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final _scaffoldBookKey = GlobalKey<ScaffoldState>();
  final _formBookKey = GlobalKey<FormState>();
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
                    hintText: 'Enter Filter',
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
                        if(_allResults.length == 0){
                          _displayList = snapshot.data;
                          _allResults = snapshot.data;
                        }
                        return new ListView.separated(
                          padding: EdgeInsets.all(10),
                          itemCount: _displayList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return new ListTile(
                                leading: const Icon(Icons.note_add),
                                title: Text(_displayList[index]['name']),
                                subtitle: Text(_displayList[index]['tag']),
                                trailing: Text('Serves ' + _displayList[index]['servings'].toString()),
                                onTap: () {
                                  Navigator.pushNamed(context, '/recipeview',arguments:{
                                    'title':_displayList[index]['name'],
                                    'data': _displayList[index]
                                  });
                                }
                            );
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
          )
        ));
  }
}
