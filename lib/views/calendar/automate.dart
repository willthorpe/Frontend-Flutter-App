import 'package:flutter/material.dart';

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

  //[Meal start, meal end, duplicates]
  List _meals = ['breakfast', 'lunch', 'dinner'];

  Map _mealsData = {
    'breakfast': [8.0, 10.0, false],
    'lunch': [12.0, 14.0, false],
    'dinner': [17.0, 20.0, false]
  };

  String _weekFrequency;
  String _eatingTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldAutomateKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
            key: _formAutomateKey,
            child: ListView(
              padding: EdgeInsets.all(15),
              children: <Widget>[
                new ListView.builder(
                    shrinkWrap: true,
                    itemCount: _meals.length,
                    itemBuilder: (BuildContext context, index) {
                      return new Column(
                        children: <Widget>[
                          ListTile(
                            title: Center(
                                child: Text(
                              'Earliest ' + _meals[index] + ' Time',
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
                                  setState(() =>
                                      _mealsData[_meals[index]][0] = rating);
                                },
                                value: _mealsData[_meals[index]][0]),
                            trailing:
                                Text(_mealsData[_meals[index]][0].toString()),
                          ),
                          ListTile(
                            title: Center(
                                child: Text(
                              'Latest ' + _meals[index] + ' Time',
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
                                  setState(() =>
                                      _mealsData[_meals[index]][1] = rating);
                                },
                                value: _mealsData[_meals[index]][1]),
                            trailing:
                                Text(_mealsData[_meals[index]][1].toString()),
                          ),
                          ListTile(
                              title: Center(
                                  child: Text(
                                'Allow duplicates for ' + _meals[index],
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              )),
                              subtitle: Checkbox(
                                  value: _mealsData[_meals[index]][2],
                                  onChanged: (bool value) {
                                    setState(() {
                                      _mealsData[_meals[index]][2] = value;
                                    });
                                  }))
                        ],
                      );
                    }),
                new ListTile(
                  title: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Eating Time'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an eating time';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _eatingTime = value;
                      }),
                ),
                new ListTile(
                  title: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Weeks since last made'),
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
                        if (_formAutomateKey.currentState.validate()) {
                          _formAutomateKey.currentState.save();
                          Navigator.pushNamed(context, '/automateresults',
                              arguments: {
                                'title': 'View Calendar',
                                'mealsData': _mealsData,
                                'weekFrequency': _weekFrequency,
                                'eatingTime': _eatingTime
                              });
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
