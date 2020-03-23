import 'package:flutter/material.dart';
import '../../http/fetch.dart';

class AutomateResultsPage extends StatefulWidget {
  AutomateResultsPage(
      {Key key, this.title, this.meals, this.weekFrequency, this.eatingTime})
      : super(key: key);

  final String title;
  final List meals;
  final int weekFrequency;
  final int eatingTime;

  @override
  _AutomateResultsPageState createState() => _AutomateResultsPageState();
}

class _AutomateResultsPageState extends State<AutomateResultsPage> {
  final _scaffoldAutomateResultKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        key: _scaffoldAutomateResultKey,
        appBar: AppBar(
          title: Text('View Calendar'),
        ),
        body: FutureBuilder(
            future: automateCalendar(arguments['mealsData'],
                arguments['weekFrequency'], arguments['eatingTime']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.separated(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Text(
                            'Day is ' + snapshot.data[index]['day'].toString()),
                        Text('Breakfast:'),
                        Text(snapshot.data[index]['breakfast'].toString()),
                        Text('Lunch:'),
                        Text(snapshot.data[index]['lunch'].toString()),
                        Text('Dinner:'),
                        Text(snapshot.data[index]['dinner'].toString()),
                      ],
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
            }));
  }
}
