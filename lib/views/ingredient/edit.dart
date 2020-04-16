import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/http/save.dart';
import 'package:validators/validators.dart';

class EditIngredientPage extends StatefulWidget {
  EditIngredientPage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final List data;

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  final _scaffoldIngredientEditKey = GlobalKey<ScaffoldState>();
  final _formIngredientKey = GlobalKey<FormState>();

  //Save the form data
  String _ingredientName = '';
  int _ingredientAmount = 0;
  String _amountType = ingredientTypes[0];
  String _ingredientStorage = '';

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    _amountType = arguments['data']['type'];
    if(_amountType == ''){
      _amountType = "number";
    }
    _ingredientName = arguments['data']['name'];

    return Scaffold(
        key: _scaffoldIngredientEditKey,
        appBar: AppBar(
          title: Text(arguments['title']),
        ),
        body: Form(
          key: _formIngredientKey,
          child: new ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.kitchen),
                  title: Text(arguments['data']['name']),
                ),
                new ListTile(
                  leading: const Icon(Icons.straighten),
                  title: TextFormField(
                      initialValue: arguments['data']['amount'].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Amount'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        if(!isNumeric(value)){
                          return 'Value must be a number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _ingredientAmount = int.parse(value);
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
                      initialValue: arguments['data']['location'].toString(),
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
                          saveAndSnackbar(_scaffoldIngredientEditKey, _ingredientName, _ingredientAmount, _amountType, _ingredientStorage);
                          _formIngredientKey.currentState.reset();
                        }
                      },
                      color: Colors.orange[300],
                      child: Text('Edit')),
                ),
              ]),
        ));
  }
}

Future saveAndSnackbar(key, name, amount, type, storage)  async {
  var response = await editIngredient(name, amount, type, storage);
  final snackBar = SnackBar(content: Text(response));
  key.currentState.showSnackBar(snackBar);
}