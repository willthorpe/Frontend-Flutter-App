import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/views/ingredient/common.dart';

class EditIngredientPage extends StatefulWidget {
  EditIngredientPage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final List data;

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  final _scaffoldIngredientEditKey = GlobalKey<ScaffoldState>();
  final _editIngredientForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    amountMeasurement = arguments['data']['measurement'];
    //Don't allow blank to be a measurement type
    if(amountMeasurement == ''){
      amountMeasurement = "number";
    }
    ingredientName = arguments['data']['name'];

    return Scaffold(
        key: _scaffoldIngredientEditKey,
        appBar: AppBar(
          title: Text(arguments['title']),
        ),
        body: Form(
          key: _editIngredientForm,
          child: new ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                //The name of the ingredient cannot change or it edits everyone's ingredients
                new ListTile(
                  leading: const Icon(Icons.kitchen),
                  title: Text(arguments['data']['name']),
                ),
                createAmountTile(arguments['data']['amount'].toString()),
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
                        if (_editIngredientForm.currentState.validate()) {
                          _editIngredientForm.currentState.save();
                          saveAndSnackbar(_scaffoldIngredientEditKey, "edit", ingredientName, ingredientAmount, amountMeasurement, ingredientStorage);
    _editIngredientForm.currentState.reset();
    }
                      },
                      color: Colors.orange[300],
                      child: Text('Edit')),
                ),
              ]),
        ));
  }
}