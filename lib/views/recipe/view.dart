import 'package:flutter/material.dart';
import 'package:flutter_app/http/delete.dart';

class ViewRecipePage extends StatefulWidget {
  ViewRecipePage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final List data;

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
                new ListTile(
                  leading: const Icon(Icons.group),
                  title: Text(arguments['data']['tag']),
                ),
                new ListTile(
                  leading: const Icon(Icons.room_service),
                  title: Text(
                      arguments['data']['servings'].toString() + ' people'),
                ),
                new ListTile(
                  leading: const Icon(Icons.av_timer),
                  title: Text('Prep Time: ' +
                      arguments['data']['prepTime'].toString() +
                      ' minutes'),
                ),
                new ListTile(
                  leading: const Icon(Icons.alarm),
                  title: Text('Cooking Time: ' +
                      arguments['data']['cookTime'].toString() +
                      ' minutes'),
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
                      child: Text('Delete Recipe?')),
                ),
              ]),
              Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (arguments['data']['ingredients'][index]['type'] ==
                            'number') {
                          return ListTile(
                            title: Text(
                              '${arguments['data']['ingredients'][index]['amount']} ${arguments['data']['ingredients'][index]['name']}',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          );
                        } else {
                          return ListTile(
                            title: Text(
                              '${arguments['data']['ingredients'][index]['amount']} ${arguments['data']['ingredients'][index]['type']} of ${arguments['data']['ingredients'][index]['name']}',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
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
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            '${arguments['data']['method'][index]}',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: arguments['data']['method'].length)),
            ])));
  }
}
