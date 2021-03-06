import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:flutter_app/http/save.dart';
import 'package:validators/validators.dart';

class ShoppingListPage extends StatefulWidget {
  ShoppingListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final _scaffoldShoppingKey = GlobalKey<ScaffoldState>();
  final _formShoppingKey = GlobalKey<FormState>();
  List _purchased = [];
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = fetchShoppingList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldShoppingKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formShoppingKey,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return new Container(
                              height: MediaQuery.of(context).size.height * 0.60,
                              child: ListView.separated(
                                padding: EdgeInsets.all(10),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if(_purchased.length < snapshot.data.length){
                                    _purchased.add({
                                      'name': snapshot.data[index]['name'],
                                      'amount': 0,
                                      'measurement': snapshot.data[index]['measurement']
                                    });
                                  }

                                  if (snapshot.data[index]['measurement'] == "number") {
                                    return new ListTile(
                                        leading: const Icon(Icons.fastfood),
                                        title: Text(snapshot.data[index]['name']),
                                        subtitle: Text(
                                            snapshot.data[index]['amount'].toString() + "\n£" + snapshot.data[index]['price'].toString()),
                                        isThreeLine: true,
                                        trailing: Container(
                                          width:
                                          MediaQuery.of(context).size.width * 0.30,
                                          child: TextFormField(
                                            initialValue: _purchased[index]['amount'].toString(),
                                              keyboardType: TextInputType.number,
                                              decoration:
                                              InputDecoration(hintText: 'Amount'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter an amount';
                                                }
                                                if(!isNumeric(value)){
                                                  return 'Value must be a number';
                                                }
                                                if (int.parse(value) <
                                                    snapshot.data[index]['amount']) {
                                                  return 'Value too small';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  _purchased[index] = {
                                                    'name': snapshot.data[index]['name'],
                                                    'amount': int.parse(value),
                                                    'measurement': snapshot.data[index]['measurement']
                                                  };
                                                });
                                              }),
                                        ));
                                  } else {
                                    return new ListTile(
                                        leading: const Icon(Icons.fastfood),
                                        title: Text(snapshot.data[index]['name']),
                                        isThreeLine: true,
                                        subtitle: Text(
                                            snapshot.data[index]['amount'].toString() +
                                                " " +
                                                snapshot.data[index]['measurement'] + "\n£" + snapshot.data[index]['price'].toString()
                                        ),
                                        trailing: Container(
                                          width:
                                          MediaQuery.of(context).size.width * 0.30,
                                          child: TextFormField(
                                              initialValue: _purchased[index]['amount'].toString(),
                                              keyboardType: TextInputType.number,
                                              decoration:
                                              InputDecoration(hintText: 'Bought'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Enter an amount';
                                                }
                                                if(!isNumeric(value)){
                                                  return 'Must be value';
                                                }
                                                if (int.parse(value) <
                                                    snapshot.data[index]['amount']) {
                                                  return 'Value too small';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  _purchased[index] = {
                                                    'name': snapshot.data[index]['name'],
                                                    'amount': int.parse(value),
                                                    'measurement': snapshot.data[index]['measurement']
                                                  };
                                                });
                                              }),
                                        ));
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                              ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                RaisedButton(
                    onPressed: () {
                      if (_formShoppingKey.currentState.validate()) {
                        _formShoppingKey.currentState.save();
                        saveShoppingList(_purchased);
                        Navigator.popAndPushNamed(context, '/shoppinglist');
                        final snackBar =
                        SnackBar(content: Text("Processing"));
                        _scaffoldShoppingKey.currentState
                            .showSnackBar(snackBar);
                      }
                    },
                    color: Colors.orange[300],
                    child: Text('Save')),
              ],
            ),
          )
        ));
  }
}
