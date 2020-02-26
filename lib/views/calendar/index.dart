import 'package:flutter/material.dart';

class CalendarsPage extends StatefulWidget {
  CalendarsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarsPageState createState() => _CalendarsPageState();
}

class _CalendarsPageState extends State<CalendarsPage> {
  final _scaffoldCalendarsKey = GlobalKey<ScaffoldState>();
  var _calendarOptions = [
    'Create Calendar',
    'Edit Calendar',
    'View Calendars',
    'Automate Calendar'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldCalendarsKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: _calendarOptions.length,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (context, index) {
              return RaisedButton(
                color: Colors.orange,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text('\n'+_calendarOptions[index]+'\n',
                          style: TextStyle(
                            fontSize: 30.0,
                          )),
                    ),
                  ],
                ),
                onPressed: (){
                  Navigator.pushNamed(context,
                      '/${_calendarOptions[index].toLowerCase().split(" ").join("")}');
                },
              );
          }
        )
    );
  }
}
