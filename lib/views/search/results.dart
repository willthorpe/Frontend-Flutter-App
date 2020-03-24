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
                return new Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                                title: Text(
                                    snapshot.data[index]['recipe']['name']),
                                trailing: Text(
                                    snapshot.data[index]['score'].toString() +
                                        "% match")),
                            Text("Tag: " +
                                snapshot.data[index]['recipe']['tag']),
                            Text("Servings: " +
                                snapshot.data[index]['recipe']['servings']
                                    .toString()),
                            Text("Prep Time: " +
                                snapshot.data[index]['recipe']['prepTime']
                                    .toString() +
                                " minutes"),
                            Text("Cook Time: " +
                                snapshot.data[index]['recipe']['cookTime']
                                    .toString() +
                                " minutes"),
                            Text('\nMethod:\n',
                                style: TextStyle(
                                  fontSize: 20.0,
                                )),
                            Container(
                              height:
                              MediaQuery.of(context).size.height * 0.3,
                              child: GridView.builder(
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.all(10),
                                  itemCount:
                                  snapshot.data[index]['method'].length,
                                  itemBuilder: (BuildContext context,
                                      int methodIndex) {
                                    return Text(snapshot.data[index]['method']
                                    [methodIndex]);
                                  }),
                            ),
                            Text('Ingredients:\n',
                                style: TextStyle(
                                  fontSize: 20.0,
                                )),
                            ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10),
                                itemCount:
                                    snapshot.data[index]['ingredients'].length,
                                itemBuilder: (BuildContext context,
                                    int ingredientIndex) {
                                  return Text(snapshot.data[index]
                                                  ['ingredients']
                                              [ingredientIndex][1]['amount']
                                          .toString()
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
                                  createLink(
                                      snapshot.data[index]['recipe']['name'],
                                      snapshot.data[index]['ingredients']);
                                  final snackBar =
                                      SnackBar(content: Text("Processing"));
                                  _scaffoldResultsKey.currentState
                                      .showSnackBar(snackBar);
                                },
                                child: Text('Add to Recipe Book')),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
