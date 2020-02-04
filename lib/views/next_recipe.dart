import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';

class NextRecipePage extends StatefulWidget {
  NextRecipePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NextRecipePageState createState() => _NextRecipePageState();
}

class _NextRecipePageState extends State<NextRecipePage> {
  @override
  Widget build(BuildContext context) {
    final _scaffoldResultsKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldResultsKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: fetchNextRecipe(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new ListTile(
                        leading: const Icon(Icons.note_add),
                        title: Text(snapshot.data[index]['name']),
                        subtitle: Column(
                          children: <Widget>[
                            Text("Tag: " + snapshot.data[index]['tag']),
                            Text("Servings: " + snapshot.data[index]['servings']),
                            Text("Prep Time: " + snapshot.data[index]['prepTime'] + " minutes"),
                            Text("Cook Time: " + snapshot.data[index]['cookTime'] + " minutes"),
                            Text("\nMethod"),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data[index]['method'].length,
                                itemBuilder: (BuildContext context, int methodIndex) {
                                  return Text(snapshot.data[index]['method'][methodIndex]);
                                }),
                            Text("\nIngredients:"),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data[index]['ingredients'].length,
                                itemBuilder: (BuildContext context, int ingredientIndex) {
                                  return Text(snapshot.data[index]['ingredients'][ingredientIndex]['amount'].toString()
                                      + " "
                                      + snapshot.data[index]['ingredients'][ingredientIndex]['type']
                                      + " "
                                      + snapshot.data[index]['ingredients'][ingredientIndex]['name']);
                                }),
                          ],
                        )
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
