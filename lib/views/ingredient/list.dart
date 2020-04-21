import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/views/ingredient/common.dart';

class ListIngredientPage extends StatefulWidget {
  ListIngredientPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListIngredientPageState createState() => _ListIngredientPageState();
}

class _ListIngredientPageState extends State<ListIngredientPage> {
  final _scaffoldIngredientListKey = GlobalKey<ScaffoldState>();
  final _listIngredientForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldIngredientListKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _listIngredientForm,
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
                        ingredientName = value;
                      }),
                ),
                createAmountTile(''),
                new ListTile(
                  leading: const Icon(Icons.line_weight),
                  title: Text(
                      'Measurement',
                    style: TextStyle(
                      color: Colors.black54
                    ),
                  ),
                  trailing: DropdownButton<String>(
                    value: amountMeasurement,
                    items: ingredientMeasurements.map((value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        amountMeasurement = newValue;
                      });
                    },
                  ),
                ),
                createStorageTile(),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        if (_listIngredientForm.currentState.validate()) {
                          _listIngredientForm.currentState.save();
                          saveAndSnackbar(_scaffoldIngredientListKey, "list", ingredientName, ingredientAmount, amountMeasurement, ingredientStorage);
                          _listIngredientForm.currentState.reset();
                        }
                      },
                      color: Colors.orange[300],
                      child: Text('Save')),
                ),
              ]),
        ));
  }
}