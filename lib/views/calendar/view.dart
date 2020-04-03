import 'package:flutter/material.dart';
import 'package:flutter_app/database/fetch.dart';
import 'package:flutter_app/database/save.dart';
import 'package:flutter_app/globals.dart';

class ViewCalendarsPage extends StatefulWidget {
  ViewCalendarsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ViewCalendarsPageState createState() => _ViewCalendarsPageState();
}

class _ViewCalendarsPageState extends State<ViewCalendarsPage> {
  final _scaffoldCalendarViewKey = GlobalKey<ScaffoldState>();
  final _formCalendarViewKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        key: _scaffoldCalendarViewKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formCalendarViewKey,
          child: FutureBuilder(
              future: fetchCalendars(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      padding: EdgeInsets.all(10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var activeWidget = Container(
                              child: RaisedButton(
                                  onPressed: () {
                                    final snackBar =
                                    SnackBar(content: Text("Processing"));
                                    _scaffoldCalendarViewKey.currentState
                                        .showSnackBar(snackBar);
                                    saveActiveCalendar(
                                        snapshot.data[index]['id']);
                                  },
                                  child: Text('Mark as Active')));
                          if (snapshot.data[index]['active'] == 1) {
                            activeWidget =
                                Container(child: Text('Currently Active'));
                          }
                          return new Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Calendar ' +
                                      snapshot.data[index]['id'].toString(),
                                  style: TextStyle(
                                    fontSize: 30.0,
                                  ),
                                ),
                                activeWidget,
                                Text('\nBreakfast:\n',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    )),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot
                                          .data[index]['breakfast'].length,
                                      itemBuilder: (BuildContext context,
                                          int breakfastIndex) {
                                        return Text(
                                            days[breakfastIndex] + ":\n" +
                                            snapshot.data[index]
                                            ['breakfast'][breakfastIndex]);
                                      }),
                                ),
                                Text(
                                  'Lunch:\n',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          snapshot.data[index]['lunch'].length,
                                      itemBuilder: (BuildContext context,
                                          int lunchIndex) {
                                        return Text(
                                            days[lunchIndex] + ":\n" +
                                                snapshot.data[index]
                                            ['lunch'][lunchIndex]);
                                      }),
                                ),
                                Text('Dinner:\n',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    )),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          snapshot.data[index]['dinner'].length,
                                      itemBuilder: (BuildContext context,
                                          int dinnerIndex) {
                                        return Text(  days[dinnerIndex] + ":\n" +
                                            snapshot.data[index]
                                            ['dinner'][dinnerIndex]);
                                      }),
                                ),
                              ],
                            ),
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
              }),
        ));
  }
}
