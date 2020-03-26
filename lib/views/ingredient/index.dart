import 'package:flutter/material.dart';
import '../../http/fetch.dart';

class IngredientsPage extends StatefulWidget {
  IngredientsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final _scaffoldIngredientsKey = GlobalKey<ScaffoldState>();
  final _formIngredientsKey = GlobalKey<FormState>();
  var _allResults = [];
  var _displayList = [];
  var _searchTerm = '';

  @override
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
                      future: fetchIngredients(),
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
                              if (_displayList[index]['type'] == "number") {
                                return new ListTile(
                                    leading: const Icon(Icons.fastfood),
                                    title: Text(_displayList[index]['name']),
                                    subtitle: Text('In ' +
                                        _displayList[index]['location'] +
                                        ' expires ' +
                                        _displayList[index]['useByDate']),
                                    trailing: Text(_displayList[index]['amount']
                                        .toString()));
                              } else {
                                return new ListTile(
                                    leading: const Icon(Icons.fastfood),
                                    title: Text(_displayList[index]['name']),
                                    subtitle: Text('In ' +
                                        _displayList[index]['location'] +
                                        ' expires ' +
                                        _displayList[index]['useByDate']),
                                    trailing: Text(
                                        _displayList[index]['amount'].toString() +
                                            ' ' +
                                            _displayList[index]['type']));
                              }
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
