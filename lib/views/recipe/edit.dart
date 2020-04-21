import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:flutter_app/http/save.dart';
import 'package:validators/validators.dart';

class EditRecipePage extends StatefulWidget {
  EditRecipePage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final List data;

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  final _scaffoldEditRecipeKey = GlobalKey<ScaffoldState>();
  String _recipeName = '';
  String _mealTime = '';
  int _recipeServings = 0;
  int _prepTime = 0;
  int _cookTime = 0;
  List _ingredients = [];
  List _methods = [''];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    _recipeName = arguments['data']['name'];
    _recipeServings = arguments['data']['servings'];
    _prepTime = arguments['data']['prepTime'];
    _cookTime = arguments['data']['cookTime'];

    if (_ingredients.length == 0) {
      for (var i = 0; i < arguments['data']['ingredients'].length; i++) {
        addCompleteIngredient(
            arguments['data']['ingredients'][i]['name'],
            arguments['data']['ingredients'][i]['amount'],
            arguments['data']['ingredients'][i]['type']);
      }
    }

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            key: _scaffoldEditRecipeKey,
            appBar: AppBar(
                title: Text(arguments['title']),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.restaurant_menu)),
                  Tab(icon: Icon(Icons.kitchen)),
                  Tab(icon: Icon(Icons.list)),
                ])),
            body: TabBarView(children: [
              Form(
                child: ListView(shrinkWrap: true, children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.timer),
                    title: DropdownButton<String>(
                      value: arguments['data']['tag'],
                      items: mealTimes.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          arguments['data']['tag'] = newValue;
                          _mealTime = arguments['data']['tag'];
                          print(_mealTime);
                        });
                      },
                    ),
                    trailing: Text(
                      'Meal Time',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.room_service),
                    title: TextFormField(
                        initialValue: arguments['data']['servings'].toString(),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: 'Servings'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a servings amount';
                          }
                          if (!isNumeric(value)) {
                            return 'Value must be a number';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _recipeServings = int.parse(value);
                        }),
                    trailing: Text('servings'),
                  ),
                  new ListTile(
                      leading: const Icon(Icons.av_timer),
                      title: TextFormField(
                          initialValue:
                              arguments['data']['prepTime'].toString(),
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: 'Preparation Time'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a preparation time';
                            }
                            if (!isNumeric(value)) {
                              return 'Value must be a number';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            _prepTime = int.parse(value);
                          }),
                      trailing: Text('minutes')),
                  new ListTile(
                      leading: const Icon(Icons.alarm),
                      title: TextFormField(
                          initialValue:
                              arguments['data']['cookTime'].toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'Cooking Time'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a cooking time';
                            }
                            if (!isNumeric(value)) {
                              return 'Value must be a number';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            _cookTime = int.parse(value);
                          }),
                      trailing: Text('minutes')),
                  Center(
                    child: RaisedButton(
                        onPressed: () {
                          final snackBar =
                              SnackBar(content: Text("Processing"));
                          _scaffoldEditRecipeKey.currentState
                              .showSnackBar(snackBar);
                          editRecipeSummary(_recipeName, _mealTime,
                              _recipeServings, _prepTime, _cookTime);
                        },
                        color: Colors.orange[300],
                        child: Text('Save')),
                  ),
                ]),
              ),
              Form(
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height * 0.60,
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
                                                      initialValue:
                                                          _ingredients[index]
                                                              ['name'],
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
                                        leading: const Icon(Icons.straighten),
                                        title: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'Amount',
                                          ),
                                          initialValue: _ingredients[index]
                                                  ['amount']
                                              .toString(),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter an amount';
                                            }
                                            if (!isNumeric(value)) {
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
                                          value: _ingredients[index]['type'],
                                          items: ingredientMeasurements
                                              .map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _ingredients[index]['type'] =
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
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, right: 10, bottom: 10),
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
                        ),
                        Center(
                          child: RaisedButton(
                              onPressed: () {
                                final snackBar =
                                    SnackBar(content: Text("Processing"));
                                _scaffoldEditRecipeKey.currentState
                                    .showSnackBar(snackBar);
                                editRecipeIngredients(
                                    _recipeName, _ingredients);
                              },
                              color: Colors.orange[300],
                              child: Text('Save')),
                        ),
                      ],
                    )),
              ),
              Form(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var initialValue = '';
                                if (index <
                                    arguments['data']['method'].length) {
                                  initialValue =
                                      arguments['data']['method'][index];
                                } else {
                                  initialValue = '';
                                }
                                return ListTile(
                                    leading: const Icon(Icons.list),
                                    title: TextFormField(
                                        decoration:
                                            InputDecoration(hintText: 'Method'),
                                        initialValue: initialValue,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a method';
                                          }
                                          return null;
                                        },
                                        onChanged: (String value) {
                                          _methods[index] = value;
                                        }),
                                    subtitle: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            _methods.removeAt(index);
                                          });
                                        },
                                        color: Colors.orange[300],
                                        child: Text('Remove Entry')));
                              },
                              itemCount: _methods.length),
                        ),
                        Center(
                          child: RaisedButton(
                              onPressed: () {
                                addMethodRow();
                              },
                              color: Colors.orange[300],
                              child: Text('Add Method Line')),
                        ),
                        Center(
                          child: RaisedButton(
                              onPressed: () {
                                final snackBar =
                                    SnackBar(content: Text("Processing"));
                                _scaffoldEditRecipeKey.currentState
                                    .showSnackBar(snackBar);
                                editRecipeMethod(_recipeName, _methods);
                              },
                              color: Colors.orange[300],
                              child: Text('Save')),
                        ),
                      ],
                    )),
              )
            ])));
  }

  void addCompleteIngredient(name, amount, type) {
    setState(() {
      _ingredients.add({
        'name': name,
        'amount': amount,
        'type': type,
        'ingredientType': 'new'
      });
    });
  }

  void addIngredientRow(ingredientType) {
    setState(() {
      _ingredients.add({
        'name': '',
        'amount': 0,
        'type': 'grams',
        'ingredientType': ingredientType
      });
    });
  }

  void addMethodRow() {
    setState(() {
      _methods.add("");
    });
  }
}
