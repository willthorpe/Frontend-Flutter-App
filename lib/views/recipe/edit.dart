import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';
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
  String _recipeTag = 'Breakfast';
  int _recipeServings = 0;
  int _prepTime = 0;
  int _cookTime = 0;
  List _ingredients = [];
  List _methods = [''];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    _recipeName = arguments['data']['name'];
    _recipeTag = arguments['data']['tag'];

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
                          if(!isNumeric(value)){
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
                          initialValue: arguments['data']['prepTime'].toString(),
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
                          onChanged: (String value) {
                            _prepTime = int.parse(value);
                          }),
                      trailing: Text('minutes')),
                  new ListTile(
                      leading: const Icon(Icons.alarm),
                      title: TextFormField(
                          initialValue: arguments['data']['cookTime'].toString(),
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
                          editRecipeSummary(_recipeName, _recipeTag, _recipeServings, _prepTime, _cookTime);
                        },
                        color: Colors.orange[300],
                        child: Text('Save')),
                  ),
                ]),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (arguments['data']['ingredients'][index]['type'] ==
                            'number') {
                          return ListTile(
                            leading: Icon(Icons.kitchen),
                            title: Text(arguments['data']['ingredients'][index]['name'],
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            trailing: Text(arguments['data']['ingredients'][index]['amount'].toString())
                          );
                        } else {
                          return ListTile(
                              leading: Icon(Icons.kitchen),
                              title: Text(arguments['data']['ingredients'][index]['name'],
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            trailing: Text("${arguments['data']['ingredients'][index]['amount']} ${arguments['data']['ingredients'][index]['type']}")
                          );
                        }
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: arguments['data']['ingredients'].length)),
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.list),
                          title: Text(
                            '${arguments['data']['method'][index]}',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        );
                      },
                      itemCount: arguments['data']['method'].length)),
            ])));
  }
}
