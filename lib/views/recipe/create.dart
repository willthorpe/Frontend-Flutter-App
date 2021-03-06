import 'package:flutter/material.dart';
import 'package:flutter_app/http/save.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:validators/validators.dart';

class CreateRecipePage extends StatefulWidget {
  CreateRecipePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CreateRecipePageState createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  final _scaffoldRecipeKey = GlobalKey<ScaffoldState>();
  int _currentStep = 0;
  String _recipeName = '';
  String _mealTime = 'Breakfast';
  int _recipeServings = 0;
  int _prepTime = 0;
  int _cookTime = 0;
  List _ingredients = [];
  List _methods = [''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldRecipeKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stepper(
            steps: [
              //Info step
              Step(
                  isActive: _currentStep >= 0,
                  title: Text('Info'),
                  content: new Form(
                      key: _formKeys[0],
                      child: ListView(shrinkWrap: true, children: <Widget>[
                        new ListTile(
                          leading: const Icon(Icons.restaurant_menu),
                          title: TextFormField(
                              decoration: InputDecoration(hintText: 'Name'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a recipe name';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _recipeName = value;
                              }),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.timer),
                          title: Text(
                            'Meal Time',
                            style: TextStyle(color: Colors.black54),
                          ),
                          trailing: DropdownButton<String>(
                            value: _mealTime,
                            items: mealTimes.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                _mealTime = newValue;
                              });
                            },
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.room_service),
                          title: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: 'Servings'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a servings amount';
                                }
                                if(!isNumeric(value)){
                                  return 'Value must be a number';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                _recipeServings = int.parse(value);
                              }),
                        ),
                        new ListTile(
                            leading: const Icon(Icons.av_timer),
                            title: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Preparation Time'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a preparation time';
                                  }
                                  if(!isNumeric(value)){
                                    return 'Value must be a number';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _prepTime = int.parse(value);
                                }),
                            trailing: Text('minutes')),
                        new ListTile(
                            leading: const Icon(Icons.alarm),
                            title: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(hintText: 'Cooking Time'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a cooking time';
                                  }
                                  if(!isNumeric(value)){
                                    return 'Value must be a number';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _cookTime = int.parse(value);
                                }),
                            trailing: Text('minutes')),
                      ]))),
              //Ingredient Step
              Step(
                isActive: _currentStep >= 1,
                title: Text('Ingredients'),
                content: Form(
                    key: _formKeys[1],
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _ingredients.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: <Widget>[
                                    ListTile(
                                        leading: const Icon(Icons.kitchen),
                                        title: FutureBuilder(
                                            future: fetchIngredients(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (_ingredients[index][
                                                            'ingredientType'] ==
                                                        'stockroom' &&
                                                    snapshot.data.length > 0) {
                                                  if (_ingredients[index]
                                                          ['name'] ==
                                                      '') {
                                                    _ingredients[index]
                                                            ['name'] =
                                                        snapshot.data[0]
                                                            ['name'];
                                                  }
                                                  //Add ingredient from stockroom
                                                  return DropdownButton<String>(
                                                      value: _ingredients[index]
                                                          ['name'],
                                                      items: snapshot.data
                                                          .map<
                                                              DropdownMenuItem<
                                                                  String>>((value) =>
                                                              new DropdownMenuItem<
                                                                  String>(
                                                                value: value[
                                                                    'name'],
                                                                child: new Text(
                                                                    value[
                                                                        'name']),
                                                              ))
                                                          .toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _ingredients[index]
                                                                  ['name'] =
                                                              newValue;
                                                        });
                                                      });
                                                } else {
                                                  //Add new ingredient
                                                  return TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: 'Name'),
                                                      initialValue: _ingredients[index]['name'],
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Please enter a food name';
                                                        }
                                                        return null;
                                                      },
                                                      onChanged:
                                                          (String value) {
                                                        _ingredients[index]
                                                            ['name'] = value;
                                                      });
                                                }
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            })),
                                    ListTile(
                                        leading:
                                            const Icon(Icons.straighten),
                                        title: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'Amount',
                                          ),
                                          initialValue: _ingredients[index]['amount'].toString(),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter an amount';
                                            }
                                            if(!isNumeric(value)){
                                              return 'Value must be a number';
                                            }
                                            return null;
                                          },
                                          onChanged: (String value) {
                                            _ingredients[index]['amount'] =
                                                int.parse(value);
                                          },
                                        )),
                                    ListTile(
                                        leading: const Icon(Icons.line_weight),
                                        title: DropdownButton<String>(
                                          value: _ingredients[index]['measurement'],
                                          items: ingredientMeasurements
                                              .map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _ingredients[index]['measurement'] =
                                                  newValue;
                                            });
                                          },
                                        )),
                                    ListTile(
                                        title: RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                _ingredients.removeAt(index);
                                              });
                                            },
                                            color: Colors.orange[300],
                                            child: Text('Remove Ingredient')))
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                            )),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: RaisedButton(
                                  onPressed: () {
                                    addIngredientRow('stockroom');
                                  },
                                  color: Colors.orange[300],
                                  child:
                                      Text('Add Ingredient \n from Stockroom')),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: RaisedButton(
                                  onPressed: () {
                                    addIngredientRow('new');
                                  },
                                  color: Colors.orange[300],
                                  child: Text('New Ingredient')),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              //Method Step
              Step(
                  isActive: _currentStep >= 2,
                  title: Text('Method'),
                  content: Form(
                    key: _formKeys[2],
                    child: Column(children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: _methods.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  leading: const Icon(Icons.list),
                                  title: TextFormField(
                                      decoration:
                                          InputDecoration(hintText: 'Method'),
                                      initialValue: _methods[index],
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a method';
                                        }
                                        return null;
                                      },
                                      onChanged: (String value) {
                                        _methods[index] = value;
                                      }),
                                  //Remove entry if the user does not wish to have any data anymore
                                  subtitle: RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          _methods.removeAt(index);
                                        });
                                      },
                                      color: Colors.orange[300],
                                      child: Text('Remove Entry')));
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          )),
                      Center(
                        child: RaisedButton(
                            onPressed: () {
                              addMethodRow();
                            },
                            color: Colors.orange[300],
                            child: Text('Add Method Line')),
                      ),
                    ]),
                  )),
            ],
            type: StepperType.horizontal,
            currentStep: this._currentStep,
            controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.orange[300],
                    onPressed: onStepCancel,
                    child: const Text('Previous'),
                  ),
                  RaisedButton(
                    color: Colors.orange[300],
                    onPressed: onStepContinue,
                    child: const Text('Next'),
                  ),
                ],
              );
            },
            onStepContinue: () {
              setState(() {
                if (this._currentStep < 2) {
                  if (_formKeys[_currentStep].currentState.validate()) {
                    _formKeys[_currentStep].currentState.save();
                    this._currentStep = this._currentStep + 1;
                  }
                } else {
                  //Save data from all the forms
                  if (_formKeys[_currentStep].currentState.validate()) {
                    _formKeys[_currentStep].currentState.save();
                    saveAndSnackbar(_scaffoldRecipeKey, _recipeName, _mealTime, _recipeServings,
                        _prepTime, _cookTime, _ingredients, _methods);
                    _formKeys[_currentStep].currentState.reset();
                  }
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (this._currentStep > 0) {
                  this._currentStep = this._currentStep - 1;
                } else {
                  this._currentStep = 0;
                }
              });
            }));
  }

  void addIngredientRow(ingredientType) {
    setState(() {
      _ingredients.add({
        'name': '',
        'amount': 0,
        'measurement': 'grams',
        'ingredientType': ingredientType
      });
      print(_ingredients);
    });
  }

  void addMethodRow() {
    setState(() {
      _methods.add("");
    });
  }
}

Future saveAndSnackbar(key, name, tag, servings, prepTime, cookTime, ingredients, methods)  async {
  var response = await saveRecipe(name, tag, servings, prepTime, cookTime, ingredients, methods);
  final snackBar = SnackBar(content: Text(response));
  key.currentState.showSnackBar(snackBar);
}