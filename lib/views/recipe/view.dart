import 'package:flutter/material.dart';
import 'package:flutter_app/http/delete.dart';

class ViewRecipePage extends StatefulWidget {
  ViewRecipePage({Key key, this.title, this.data, this.leftover}) : super(key: key);

  final String title;
  final List data;
  final String leftover;

  @override
  _ViewRecipePageState createState() => _ViewRecipePageState();
}

class _ViewRecipePageState extends State<ViewRecipePage> {
  final _scaffoldViewRecipeKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            key: _scaffoldViewRecipeKey,
            appBar: AppBar(
                title: Text(arguments['title']),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.restaurant_menu)),
                  Tab(icon: Icon(Icons.kitchen)),
                  Tab(icon: Icon(Icons.list)),
                ])),
            body: TabBarView(children: [
              ListView(shrinkWrap: true, children: <Widget>[
                ListTile(
                  leading: Icon(Icons.timer),
                  title: Text(arguments['data']['tag'].toString()),
                  trailing: Text("Meal Time"),
                ),
                ListTile(
                  leading: Icon(Icons.room_service),
                  title: Text(arguments['data']['servings'].toString()),
                  trailing: Text("Servings"),
                ),
                ListTile(
                  leading: Icon(Icons.av_timer),
                  title: Text("${arguments['data']['prepTime'].toString()} minutes"),
                  trailing: Text("Prep Time"),),
                ListTile(
                  leading: Icon(Icons.alarm),
                  title: Text("${arguments['data']['cookTime'].toString()} minutes"),
                  trailing: Text("Cook Time"),
                ),
                ListTile(
                  leading: Icon(Icons.redo),
                  title: Text(arguments['leftover'].toString()),
                  trailing: Text("Leftovers"),
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        final snackBar =
                        SnackBar(content: Text("Processing"));
                        _scaffoldViewRecipeKey.currentState
                            .showSnackBar(snackBar);
                        deleteRecipe(arguments['title']);
                      },
                      color: Colors.orange[300],
                      child: Text('Delete Recipe?')),
                ),
              ]),
              Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (arguments['data']['ingredients'][index]['measurement'] ==
                            'number') {
                          return ListTile(
                            leading: Icon(Icons.kitchen),
                            title: Text(arguments['data']['ingredients'][index]['name'],
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            trailing: Text(arguments['data']['ingredients'][index]['amount'])
                          );
                        } else {
                          return ListTile(
                              leading: Icon(Icons.kitchen),
                              title: Text(arguments['data']['ingredients'][index]['name'],
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            trailing: Text("${arguments['data']['ingredients'][index]['amount']} ${arguments['data']['ingredients'][index]['measurement']}")
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
