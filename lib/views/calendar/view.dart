import 'package:flutter/material.dart';
import '../../database/fetch.dart';
import '../../database/save.dart';

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
                  return new ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Text('Breakfast'),
                            Text(snapshot.data[index]['breakfast'].toString()),
                            Text('Lunch'),
                            Text(snapshot.data[index]['lunch'].toString()),
                            Text('Dinner'),
                            Text(snapshot.data[index]['dinner'].toString()),
                            Text('Active'),
                            Text("Currently " + snapshot.data[index]['active'].toString()),
                            RaisedButton(
                                onPressed: () {
                                  saveActiveCalendar(snapshot.data[index]['id']);
                                },
                                child: Text('Mark as Active Calendar')),
                          ],
                        ),
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
        )
    );
  }
}
