import 'package:flutter/material.dart';
import '../../database/fetch.dart';

class ViewCalendarsPage extends StatefulWidget {
  ViewCalendarsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ViewCalendarsPageState createState() => _ViewCalendarsPageState();
}

class _ViewCalendarsPageState extends State<ViewCalendarsPage> {
  final _scaffoldCalendarViewKey = GlobalKey<ScaffoldState>();
  final _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldCalendarViewKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: fetchCalendars(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                   return Container(
                     child: Column(
                       children: <Widget>[
                         Text('Breakfast'),
                         Text(snapshot.data[index]['breakfast']),
                         Text('Lunch'),
                         Text(snapshot.data[index]['lunch']),
                         Text('Dinner'),
                         Text(snapshot.data[index]['dinner']),
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
    );
  }
}
