import 'package:flutter_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:flutter_app/http/save.dart';

//Save the form data
String ingredientName = '';
int ingredientAmount = 0;
String amountMeasurement = ingredientMeasurements[0];
String ingredientStorage = '';

createAmountTile(initialValue) {
  return new ListTile(
    leading: const Icon(Icons.straighten),
    title: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: 'Amount'),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter an amount';
          }
          if (!isNumeric(value)) {
            return 'Value must be a number';
          }
          return null;
        },
        onSaved: (value) {
          ingredientAmount = int.parse(value);
        }),
  );
}

createStorageTile() {
  return new ListTile(
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
          ingredientStorage = value;
        }),
  );
}

Future saveAndSnackbar(key, form, name, amount, measurement, storage)  async {
  var response = '';

  if(form == "list"){
    response = await saveIngredient(name, amount, measurement, storage);
  }else{
    response = await editIngredient(name, amount, measurement, storage);
  }
  final snackBar = SnackBar(content: Text(response));
  key.currentState.showSnackBar(snackBar);
}