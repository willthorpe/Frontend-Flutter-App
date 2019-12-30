import 'package:flutter/material.dart';
import 'package:flutter_app/http/delete.dart';

class RecipeDetailPage extends StatefulWidget {
  RecipeDetailPage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final List data;

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final _scaffoldBookKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute
        .of(context)
        .settings
        .arguments as Map;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                title: Text(arguments['title']),
                bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.note_add)),
                      Tab(icon: Icon(Icons.fastfood)),
                      Tab(icon: Icon(Icons.subject)),
                    ]
                )
            ),
          body: TabBarView(
            children: [
              ListView(shrinkWrap: true, children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.group),
                    title: Text(arguments['data']['tag']),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.room_service),
                    title: Text(arguments['data']['servings'] + ' people'),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.av_timer),
                    title: Text('Prep Time: ' +
                        arguments['data']['prepTime'] +
                        ' minutes'),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.av_timer),
                    title: Text('Cooking Time: ' +
                        arguments['data']['cookTime'] +
                        ' minutes'),
                  ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        deleteRecipe(arguments['title']);
                      },
                      child: Text('Delete Recipe?')),
                ),
                ]
              ),
            Container(
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
            ]
          )
        )
    );
  }
}
