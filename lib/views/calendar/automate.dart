import 'package:flutter/material.dart';
import '../../http/fetch.dart';

class AutomateCalendarPage extends StatefulWidget {
  AutomateCalendarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AutomateCalendarPageState createState() => _AutomateCalendarPageState();
}

class _AutomateCalendarPageState extends State<AutomateCalendarPage> {
  final _scaffoldAutomateKey = GlobalKey<ScaffoldState>();
  final _formAutomateKey = GlobalKey<FormState>();

  //Save the form data
  List<double> _breakfast = [8, 10];
  List<double> _lunch = [12, 14];
  List<double> _dinner = [17, 20];
  String _weekFrequency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldAutomateKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:  Form(
                key: _formAutomateKey,
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: <Widget>[
                    new ListTile(
                      title: Center(
                          child: Text(
                            'Earliest Breakfast Time',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )),
                      subtitle: Slider(
                          activeColor: Colors.lightGreen,
                          min: 0,
                          max: 24,
                          divisions: 24,
                          onChanged: (rating) {
                            setState(() => _breakfast[0] = rating);
                          },
                          value: _breakfast[0]),
                      trailing: Text(_breakfast[0].toString()),
                    ),
                    new ListTile(
                      title: Center(
                          child: Text(
                            'Latest Breakfast Time',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )),
                      subtitle: Slider(
                          activeColor: Colors.lightGreen,
                          min: 0,
                          max: 24,
                          divisions: 24,
                          onChanged: (rating) {
                            setState(() => _breakfast[1] = rating);
                          },
                          value: _breakfast[1]),
                      trailing: Text(_breakfast[1].toString()),
                    ),
                    new ListTile(
                      title: Center(
                          child: Text(
                            'Earliest Lunch Time',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )),
                      subtitle: Slider(
                          activeColor: Colors.lightGreen,
                          min: 0,
                          max: 24,
                          divisions: 24,
                          onChanged: (rating) {
                            setState(() => _lunch[0] = rating);
                          },
                          value: _lunch[0]),
                      trailing: Text(_lunch[0].toString()),
                    ),
                    new ListTile(
                      title: Center(
                          child: Text(
                            'Latest Lunch Time',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )),
                      subtitle: Slider(
                          activeColor: Colors.lightGreen,
                          min: 0,
                          max: 24,
                          divisions: 24,
                          onChanged: (rating) {
                            setState(() => _lunch[1] = rating);
                          },
                          value: _lunch[1]),
                      trailing: Text(_lunch[1].toString()),
                    ),
                    new ListTile(
                      title: Center(
                          child: Text(
                            'Earliest Dinner Time',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )),
                      subtitle: Slider(
                          activeColor: Colors.lightGreen,
                          min: 0,
                          max: 24,
                          divisions: 24,
                          onChanged: (rating) {
                            setState(() => _dinner[0] = rating);
                          },
                          value: _dinner[0]),
                      trailing: Text(_dinner[0].toString()),
                    ),
                    new ListTile(
                      title: Center(
                          child: Text(
                            'Latest Dinner Time',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )),
                      subtitle: Slider(
                          activeColor: Colors.lightGreen,
                          min: 0,
                          max: 24,
                          divisions: 24,
                          onChanged: (rating) {
                            setState(() => _dinner[1] = rating);
                          },
                          value: _dinner[1]),
                      trailing: Text(_dinner[1].toString()),
                    ),
                    new ListTile(
                      title: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Weeks since last made'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a week frequency';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _weekFrequency = value;
                          }),
                    ),
                    Center(
                      child: RaisedButton(
                          onPressed: () {
                            if (_formAutomateKey.currentState
                                .validate()) {
                              _formAutomateKey.currentState.save();
                              automateCalendar(_breakfast,_lunch,_dinner,_weekFrequency);
                              final snackBar =
                              SnackBar(content: Text("Processing"));
                              _scaffoldAutomateKey.currentState
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text('Save')),
                    ),
                  ],
                )));
  }
}