import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:flutter_app/http/save.dart';

class SearchResultsPage extends StatefulWidget {
  SearchResultsPage({Key key, this.title, this.data}) : super(key: key);

  final String title;
  final List data;

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final _scaffoldResultsKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldResultsKey,
        appBar: AppBar(
          title: Text(arguments['title']),
        ),
        body: FutureBuilder(
            future: fetchSearchResults(arguments['data']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return new ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new ListTile(
                        leading: const Icon(Icons.note_add),
                        title: Text(snapshot.data[index]['recipe']['name']),
                        trailing: Text(
                            snapshot.data[index]['score'].toString() +
                                "% match"),
                        subtitle: Column(
                          children: <Widget>[
                            Text("Tag: " +
                                snapshot.data[index]['recipe']['tag']),
                            Text("Servings: " +
                                snapshot.data[index]['recipe']['servings'].toString()),
                            Text("Prep Time: " +
                                snapshot.data[index]['recipe']['prepTime'].toString() +
                                " minutes"),
                            Text("Cook Time: " +
                                snapshot.data[index]['recipe']['cookTime'].toString() +
                                " minutes"),
                            Text("\nMethod"),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    snapshot.data[index]['method'].length,
                                itemBuilder:
                                    (BuildContext context, int methodIndex) {
                                  return Text(snapshot.data[index]['method']
                                      [methodIndex]);
                                }),
                            Text("\nIngredients:"),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    snapshot.data[index]['ingredients'].length,
                                itemBuilder: (BuildContext context,
                                    int ingredientIndex) {
                                  return Text(snapshot.data[index]
                                                  ['ingredients']
                                              [ingredientIndex][1]['amount'].toString()
                                          .toString() +
                                      " " +
                                      snapshot.data[index]['ingredients']
                                          [ingredientIndex][1]['type'] +
                                      " " +
                                      snapshot.data[index]['ingredients']
                                          [ingredientIndex][0]['name']);
                                }),
                            RaisedButton(
                                onPressed: () {
                                  createLink(snapshot.data[index]['recipe']['name']);
                                  final snackBar =
                                      SnackBar(content: Text("Processing"));
                                  _scaffoldResultsKey.currentState
                                      .showSnackBar(snackBar);
                                },
                                child: Text('Add to Recipe Book')),
                          ],
                        ));
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
