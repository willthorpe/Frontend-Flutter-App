import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:flutter_app/http/delete.dart';

class IngredientsPage extends StatefulWidget {
  IngredientsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  Future _future;
  final _scaffoldIngredientsKey = GlobalKey<ScaffoldState>();
  final _formIngredientsKey = GlobalKey<FormState>();
  var _allResults = [];
  var _displayList = [];
  var _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _future = fetchIngredients();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldIngredientsKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
            key: _formIngredientsKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter ingredient to search',
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
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (_allResults.length == 0) {
                            _allResults = snapshot.data;
                            _displayList = _allResults;
                          }

                          return new ListView.separated(
                            padding: EdgeInsets.all(10),
                            itemCount: _displayList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return createListTile(
                                  _displayList[index], context);
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

createListTile(parameters, context) {
  final _listKey = GlobalKey<ScaffoldState>();
  if (parameters['type'] == "number") {
    parameters['type'] = "";
  }
  return ListTile(
      key: _listKey,
      leading: const Icon(Icons.kitchen),
      title: Text(parameters['name']),
      subtitle: Text("In " + parameters['location']),
      trailing: Text('${parameters["amount"]} ${parameters["type"]}'),
      onTap: () {
        RenderBox box = _listKey.currentContext.findRenderObject();
        Offset position = box.localToGlobal(Offset.zero);
        showMenu(
            context: context,
            position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
            items: [
              PopupMenuItem(
                  child: FlatButton(
                color: Colors.white,
                child: Text('Edit Ingredient'),
                onPressed: () {
                  Navigator.pushNamed(context, '/editingredient', arguments: {
                    'title': 'Edit ' + parameters['name'],
                    'data': parameters
                  });
                },
              )),
              PopupMenuItem(
                  child: FlatButton(
                color: Colors.white,
                child: Text('Delete Ingredient'),
                onPressed: () {
                  deleteIngredient(parameters['name']);
                  Navigator.popAndPushNamed(context, '/larder');
                },
              )),
            ]);
      });
}
