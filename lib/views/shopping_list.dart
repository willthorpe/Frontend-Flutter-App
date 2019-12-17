import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';

class ShoppingListPage extends StatefulWidget {
  ShoppingListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final _scaffoldShoppingKey = GlobalKey<ScaffoldState>();
  final _formShoppingKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldShoppingKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formShoppingKey,
          child: FutureBuilder(
              future: fetchShoppingList(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  return new ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(snapshot.data[index]['type'] == "number"){
                        return new ListTile(
                            leading: const Icon(Icons.fastfood),
                            title: Text(snapshot.data[index]['name']),
                            trailing: Text(snapshot.data[index]['amount'].toString())
                        );
                      }else{
                        return new ListTile(
                            leading: const Icon(Icons.fastfood),
                            title: Text(snapshot.data[index]['name']),
                            trailing: Text(snapshot.data[index]['amount'].toString() + " " + snapshot.data[index]['type'])
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
