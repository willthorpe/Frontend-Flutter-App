import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:flutter_app/http/save.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldShoppingKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formShoppingKey,
          child: FutureBuilder(
              future: fetchShoppingList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new Column(children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data[index]['type'] == "number") {
                            return new ListTile(
                                leading: const Icon(Icons.fastfood),
                                title: Text(snapshot.data[index]['name']),
                                subtitle: Text(
                                    snapshot.data[index]['amount'].toString()),
                                trailing: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration:
                                          InputDecoration(hintText: 'Amount'),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter an amount';
                                        }
                                        if (int.parse(value) <
                                            snapshot.data[index]['amount']) {
                                          return 'Value too small';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        this._purchased.add({
                                          'name': snapshot.data[index]['name'],
                                          'amount': int.parse(value),
                                          'type': snapshot.data[index]['type']
                                        });
                                      }),
                                ));
                          } else {
                            return new ListTile(
                                leading: const Icon(Icons.fastfood),
                                title: Text(snapshot.data[index]['name']),
                                subtitle: Text(
                                    snapshot.data[index]['amount'].toString() +
                                        " " +
                                        snapshot.data[index]['type']),
                                trailing: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration:
                                          InputDecoration(hintText: 'Bought'),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter an amount';
                                        }
                                        if (int.parse(value) <
                                            snapshot.data[index]['amount']) {
                                          return 'Value too small';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        this._purchased.add({
                                          'name': snapshot.data[index]['name'],
                                          'amount': int.parse(value),
                                          'type': snapshot.data[index]['type']
                                        });
                                      }),
                                ));
                          }
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    ),
                    RaisedButton(
                        onPressed: () {
                          if (_formShoppingKey.currentState.validate()) {
                            _formShoppingKey.currentState.save();
                            saveShoppingList(_purchased);
                            final snackBar =
                                SnackBar(content: Text("Processing"));
                            _scaffoldShoppingKey.currentState
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text('Save')),
                  ]);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
