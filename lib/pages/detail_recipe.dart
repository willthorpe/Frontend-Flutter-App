import 'package:flutter/material.dart';
import 'package:flutter_app/pages/create_ingredient.dart';
import '../http/fetch.dart';
import 'create_ingredient.dart';

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
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
        key: _scaffoldBookKey,
        appBar: AppBar(
          title: Text(arguments['title']),
        ),
        body: ListView(shrinkWrap: true, children: <Widget>[
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
            title: Text('Prep Time: ' + arguments['data']['prepTime'] + ' minutes'),
          ),
          new ListTile(
            leading: const Icon(Icons.av_timer),
            title: Text('Cooking Time: ' + arguments['data']['cookTime'] + ' minutes'),
          ),
        ]));
  }
}
