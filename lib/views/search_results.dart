import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';

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
                return new ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new ListTile(
                      leading: const Icon(Icons.note_add),
                      title: Text(snapshot.data[index]['recipe']['name'] + " " + snapshot.data[index]['score'].toString() + "% match"),
                      subtitle: Column(
                        children: <Widget>[
                          Text("Tag: " + snapshot.data[index]['recipe']['tag']),
                          Text("Servings: " + snapshot.data[index]['recipe']['servings']),
                          Text("Prep Time: " + snapshot.data[index]['recipe']['prepTime'] + " minutes"),
                          Text("Cook Time: " + snapshot.data[index]['recipe']['cookTime'] + " minutes"),
                          Text("Method: " + snapshot.data[index]['recipe']['method']),
                          
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
