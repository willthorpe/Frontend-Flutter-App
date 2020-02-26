import 'package:flutter/material.dart';
import '../../http/fetch.dart';

class IngredientsPage extends StatefulWidget {
  IngredientsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final _scaffoldIngredientsKey = GlobalKey<ScaffoldState>();
  final _formIngredientsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldIngredientsKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formIngredientsKey,
          child: FutureBuilder(
              future: fetchIngredients(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(snapshot.data[index]['type'] == "number"){
                        return new ListTile(
                            leading: const Icon(Icons.fastfood),
                            title: Text(snapshot.data[index]['name']),
                            subtitle: Text('In ' +
                                snapshot.data[index]['location'] +
                                ' expires ' +
                                snapshot.data[index]['useByDate']),
                            trailing: Text(snapshot.data[index]['amount'])
                        );
                      }else {
                        return new ListTile(
                            leading: const Icon(Icons.fastfood),
                            title: Text(snapshot.data[index]['name']),
                            subtitle: Text('In ' +
                                snapshot.data[index]['location'] +
                                ' expires ' +
                                snapshot.data[index]['useByDate']),
                            trailing: Text(snapshot.data[index]['amount'] +
                                ' ' +
                                snapshot.data[index]['type'])
                        );
                      }
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
