import 'package:flutter/material.dart';
import 'globals.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                width: 310,
                height: 90.0,
                child: DrawerHeader(
                  child: Text(
                    'MENU',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text('${menuItems[index]}',
                              style: TextStyle(
                                fontSize: 15.0,
                              )),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context,'/${menuItems[index].toLowerCase().trim()}');
                          });
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: menuItems.length),
              ),
            ],
          ),
        ),
        body: Center());
  }
}
