import 'package:flutter/material.dart';
import 'globals.dart';
import 'fetch.dart';

class StockroomPage extends StatefulWidget {
  StockroomPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StockroomPageState createState() => _StockroomPageState();
}

class _StockroomPageState extends State<StockroomPage> {
  final _scaffoldStockroomKey = GlobalKey<ScaffoldState>();
  final _formStockroomKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldStockroomKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formStockroomKey,
          child: FutureBuilder(
              future: fetchIngredients(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new ListTile(
                          leading: const Icon(Icons.fastfood),
                          title: Text(snapshot.data[index]['name']),
                          subtitle: Text('In ' +
                              snapshot.data[index]['location'] +
                              ' expires ' +
                              snapshot.data[index]['sellByDate']),
                          trailing: Text(snapshot.data[index]['amount'] +
                              ' ' +
                              snapshot.data[index]['type']));
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
