import 'package:flutter/material.dart';
import '../globals.dart';

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
        drawer: Container(
          width: MediaQuery.of(context).size.height * 0.25,
          child: Drawer(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: DrawerHeader(
                    child: Text("Menu",
                        style: TextStyle(
                          fontSize: 25.0,
                        )),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top:0),
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text('${menuItems[index]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                )),
                            onTap: () {
                              Navigator.popAndPushNamed(context,
                                  '/${menuItems[index].toLowerCase().split(" ").join("")}');
                            });
                      },
                      itemCount: menuItems.length),
                ),
              ],
            ),
          ),
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            RaisedButton(
              color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('\nCreate',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                  Center(
                    child: Text('Food',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  )
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context,
                    '/createingredient');
              },
            ),
            RaisedButton(
              color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('\nCreate',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                  Center(
                    child: Text('Recipe',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  )
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context,
                    '/createrecipe');
              },
            ),
            RaisedButton(
              color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('\nView',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                  Center(
                    child: Text('Food',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  )
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context,
                    '/ingredients');
              },
            ),
            RaisedButton(
              color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('\nView',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                  Center(
                    child: Text('Recipes',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  )
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context,
                    '/recipebook');
              },
            ),
            RaisedButton(
              color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('\nRecipe',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                  Center(
                    child: Text('Calendar',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  )
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context,
                    '/recipecalendar');
              },
            ),
            RaisedButton(
              color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('\nShopping',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                  Center(
                    child: Text('List',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  )
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context,
                    '/shoppinglist');
              },
            ),
            RaisedButton(
              color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('\n\nSearch',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context,
                    '/search');
              },
            ),
            RaisedButton(
              color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('\n\nSettings',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context,
                    '/settings');
              },
            ),
          ],
        ));
  }
}
