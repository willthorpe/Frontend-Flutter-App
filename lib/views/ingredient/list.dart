import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/http/save.dart';

class ListIngredientPage extends StatefulWidget {
  ListIngredientPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListIngredientPageState createState() => _ListIngredientPageState();
}

class _ListIngredientPageState extends State<ListIngredientPage> {
  final _scaffoldIngredientKey = GlobalKey<ScaffoldState>();
  final _formIngredientKey = GlobalKey<FormState>();

  //Save the form data
  String _ingredientName = '';
  String _ingredientAmount = '';
  String _amountType = ingredientTypes[0];
  String _ingredientStorage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldIngredientKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formIngredientKey,
          child: new ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.kitchen),
                  title: TextFormField(
                      decoration: InputDecoration(hintText: 'Name'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a food name';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _ingredientName = value;
                      }),
                ),
                new ListTile(
                  leading: const Icon(Icons.straighten),
                  title: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Amount'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _ingredientAmount = value;
                      }),
                ),
                new ListTile(
                  leading: const Icon(Icons.line_weight),
                  title: Text(
                      'Measurement',
                    style: TextStyle(
                      color: Colors.black54
                    ),
                  ),
                  trailing: DropdownButton<String>(
                    value: _amountType,
                    items: ingredientTypes.map((value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        _amountType = newValue;
                      });
                    },
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.location_city),
                  title: TextFormField(
                      decoration: InputDecoration(hintText: 'Storage Location'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a storage location';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _ingredientStorage = value;
                      }
                  ),
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        if (_formIngredientKey.currentState.validate()) {
                          _formIngredientKey.currentState.save();
                          saveAndSnackbar(_scaffoldIngredientKey, _ingredientName, _ingredientAmount, _amountType, _ingredientStorage);
                          _formIngredientKey.currentState.reset();
                        }
                      },
                      color: Colors.orange[300],
                      child: Text('Save')),
                ),
              ]),
        ));
  }
}

Future saveAndSnackbar(key, name, amount, type, storage)  async {
  var response = await saveIngredient(name, amount, type, storage);
  final snackBar = SnackBar(content: Text(response));
  key.currentState.showSnackBar(snackBar);
}