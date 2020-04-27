import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:flutter_app/database/save.dart';

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
        body: Container(
            child: Column(
              children: <Widget>[
                FutureBuilder(
                    future: automateCalendar(arguments['mealsData'],
                        arguments['weekFrequency'], arguments['eatingTime']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("end");
                        print(new DateTime.now().millisecondsSinceEpoch);
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.8,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(10),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: <Widget>[
                                          Text('Day is ' +
                                              snapshot.data[index]['day']
                                                  .toString()),
                                          Text('Breakfast:'),
                                          Text(snapshot.data[index]['breakfast']
                                              .toString()),
                                          Text('Lunch:'),
                                          Text(snapshot.data[index]['lunch']
                                              .toString()),
                                          Text('Dinner:'),
                                          Text(snapshot.data[index]['dinner']
                                              .toString()),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                  ),
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    child:  RaisedButton(
                                      onPressed: () {
                                        saveAutomateCalendar(snapshot.data);
                                        final snackBar =
                                        SnackBar(content: Text("Processing"));
                                        _scaffoldAutomateResultKey.currentState
                                            .showSnackBar(snackBar);
                                      },
                                      color: Colors.orange[300],
                                      child: Text('Save Calendar')),
                                )
                              ],
                            ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
              ],
            )));
  }
}
