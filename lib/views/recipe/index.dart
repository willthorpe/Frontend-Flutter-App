import 'package:flutter/material.dart';
import '../../http/fetch.dart';

class BookPage extends StatefulWidget {
  BookPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final _scaffoldBookKey = GlobalKey<ScaffoldState>();
  final _formBookKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldBookKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formBookKey,
          child: FutureBuilder(
              future: fetchRecipes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return new ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new ListTile(
                          leading: const Icon(Icons.note_add),
                          title: Text(snapshot.data[index]['name']),
                          subtitle: Text(snapshot.data[index]['tag']),
                          trailing: Text('Serves ' + snapshot.data[index]['servings'].toString()),
                          onTap: () {
                            Navigator.pushNamed(context, '/recipeview',arguments:{
                              'title':snapshot.data[index]['name'],
                              'data': snapshot.data[index]
                            });
                          }
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
              }),
        ));
  }
}
