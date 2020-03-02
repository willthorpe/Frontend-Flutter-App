import 'package:flutter/material.dart';
import 'package:flutter_app/database/save.dart';

class CreateNutritionPage extends StatefulWidget {
  CreateNutritionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateNutritionPageState createState() => _CreateNutritionPageState();
}

class _CreateNutritionPageState extends State<CreateNutritionPage> {
  final _scaffoldNutritionKey = GlobalKey<ScaffoldState>();
  final _formNutritionKey = GlobalKey<FormState>();

  //Save the form data
  Map _nutrition = {"calories": 0, "fat": 0, "carbohydrate": 0, "protein": 0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldNutritionKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formNutritionKey,
          child: new ListView(padding: const EdgeInsets.all(10), children: <
              Widget>[
            new ListTile(
              leading: const Icon(Icons.arrow_right),
              title: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Calories'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a calorie amount';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    this._nutrition["calories"] = int.parse(value);
                  }),
            ),
            new ListTile(
              leading: const Icon(Icons.arrow_right),
              title: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Fat'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a fat amount';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    this._nutrition["fat"] = int.parse(value);
                  }),
            ),
            new ListTile(
              leading: const Icon(Icons.arrow_right),
              title: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Carbohydrates'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a carbohydrate amount';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    this._nutrition["carbohydrate"] = int.parse(value);
                  }),
            ),
            new ListTile(
              leading: const Icon(Icons.arrow_right),
              title: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Protein'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a protein amount';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    this._nutrition["protein"] = int.parse(value);
                  }),
            ),
            Center(
              child: RaisedButton(
                  onPressed: () {
                    if (_formNutritionKey.currentState.validate()) {
                      _formNutritionKey.currentState.save();
                      print(_formNutritionKey.currentState);
                      saveNutrition(_nutrition);
                      final snackBar = SnackBar(content: Text("Processing"));
                      _scaffoldNutritionKey.currentState.showSnackBar(snackBar);
                    }
                  },
                  child: Text('Save')),
            ),
          ]),
        ));
  }
}
