import 'package:flutter/material.dart';
import 'package:flutter_app/save.dart';
import 'dart:async';
import 'dart:io';
import 'globals.dart';
import 'package:image_picker/image_picker.dart';

class RecipePage extends StatefulWidget {
  RecipePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  final ScrollController scrollController = ScrollController();
  int _currentStep = 0;
  String _recipeName = '';
  String _recipeTag = 'Breakfast';
  String _recipeServings = '';
  String _prepTime = '';
  String _cookTime = '';
  File _recipeImage;
  List _amounts = new List (10);
  List _types = new List.filled (10,'grams');
  List _ingredients = new List.filled(10, 'Ingredient');
  List _methods = new List(12);

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _recipeImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          leading: const Icon(Icons.note_add),
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
                          leading: const Icon(Icons.group),
                          title: Text(
                            'Tag',
                            style: TextStyle(color: Colors.black54),
                          ),
                          trailing: DropdownButton<String>(
                            value: _recipeTag,
                            items: recipeTags.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                _recipeTag = newValue;
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
                                return null;
                              },
                              onSaved: (String value) {
                                _recipeServings = value;
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
                                  return null;
                                },
                                onSaved: (String value) {
                                  _prepTime = value;
                                }),
                            trailing: Text('minutes')),
                        new ListTile(
                            leading: const Icon(Icons.av_timer),
                            title: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(hintText: 'Cooking Time'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a cooking time';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  _cookTime = value;
                                }),
                            trailing: Text('minutes')),
                        new ListTile(
                          leading: const Icon(Icons.add_a_photo),
                          title: Container(
                            width: 150,
                            child: RaisedButton(
                                onPressed: getImage, child: Text('Photo')),
                          ),
                          trailing: _recipeImage == null
                              ? Text('No image selected.')
                              : Image.file(_recipeImage),
                        ),
                      ]))),
              //Ingredient Step
              Step(
                  isActive: _currentStep >= 1,
                  title: Text('Ingredients'),
                  content: new Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Form(
                        key: _formKeys[1],
                        child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                      leading: const Icon(Icons.fastfood),
                                      title: DropdownButton<String>(
                                        value: _ingredients[index],
                                        items: <String>['Ingredient']
                                            .map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _ingredients[index]= newValue;
                                          });
                                        },
                                      )),
                                  ListTile(
                                      leading: const Icon(Icons.exposure_zero),
                                      title: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: 'Amount',
                                          helperText: index.toString()),
//                                          validator: (value) {
//                                            if (value.isEmpty) {
//                                              return 'Please enter an amount';
//                                            }
//                                            return null;
//                                          },
//                                          onSaved: (String value) {
//                                            _ingredients[index]['amount'] =
//                                                value;
//                                          },
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _amounts[index] =
                                                newValue;
                                          });
                                        },)),
                                  ListTile(
                                      leading: const Icon(Icons.line_weight),
                                      title: DropdownButton<String>(
                                        value: _types[index],
                                        items:
                                            ingredientTypes.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _types[index] = newValue;
                                          });
                                        },
                                      ))
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: 10),
                      ))),
              //Method Step
              Step(
                  isActive: _currentStep >= 2,
                  title: Text('Method'),
                  content: new Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Form(
                        key: _formKeys[2],
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.subject),
                                title: TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Method'),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter a method';
//                                  }
//                                  return null;
//                                },
                                    onSaved: (String value) {
                                      _methods[index] = value;
                                    }),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: 12),
                      ))),
            ],
            type: StepperType.horizontal,
            currentStep: this._currentStep,
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
                    saveRecipe(_recipeName, _recipeTag, _recipeServings,
                        _prepTime, _cookTime, _ingredients, _amounts, _types, _methods);
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
}
