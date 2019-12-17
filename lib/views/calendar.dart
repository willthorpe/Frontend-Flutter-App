import 'package:flutter/material.dart';
import '../http/fetch.dart';
import '../database/save.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _scaffoldCalendarKey = GlobalKey<ScaffoldState>();
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  int _currentStep = 0;
  final _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  //Save the form data
  List _recipes = [['','','','','','',''],['','','','','','',''],['','','','','','','']];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldCalendarKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stepper(
            steps: [
              //Breakfast step
              Step(
                  isActive: _currentStep >= 0,
                  title: Text('Breakfast'),
                  content: new Form(
                      key: _formKeys[0],
                      child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  leading: Text(_days[index],
                                      style: TextStyle(fontSize: 15.0)),
                                  title: FutureBuilder(
                                      future: fetchRecipes(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (_recipes[0][index] == '') {
                                            _recipes[0][index] =
                                                snapshot.data[0]['name'];
                                          }
                                          return DropdownButton<String>(
                                              value: _recipes[0][index],
                                              items: snapshot.data
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((value) =>
                                                      new DropdownMenuItem<
                                                          String>(
                                                        value: value['name'],
                                                        child: new Text(
                                                            value['name']),
                                                      ))
                                                  .toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _recipes[0][index] = newValue;
                                                });
                                              });
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }));
                            },
                            itemCount: 7)
                      )),
              //Lunch step
              Step(
                  isActive: _currentStep >= 0,
                  title: Text('Lunch'),
                  content: new Form(
                      key: _formKeys[1],
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: Text(_days[index],
                                    style: TextStyle(fontSize: 15.0)),
                                title: FutureBuilder(
                                    future: fetchRecipes(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (_recipes[1][index] == '') {
                                          _recipes[1][index] =
                                          snapshot.data[0]['name'];
                                        }
                                        return DropdownButton<String>(
                                            value: _recipes[1][index],
                                            items: snapshot.data
                                                .map<
                                                DropdownMenuItem<
                                                    String>>((value) =>
                                            new DropdownMenuItem<
                                                String>(
                                              value: value['name'],
                                              child: new Text(
                                                  value['name']),
                                            ))
                                                .toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _recipes[1][index] = newValue;
                                              });
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }));
                          },
                          itemCount: 7)
                  )),
              //Dinner step
              Step(
                  isActive: _currentStep >= 0,
                  title: Text('Dinner'),
                  content: new Form(
                      key: _formKeys[2],
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: Text(_days[index],
                                    style: TextStyle(fontSize: 15.0)),
                                title: FutureBuilder(
                                    future: fetchRecipes(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (_recipes[2][index] == '') {
                                          _recipes[2][index] =
                                          snapshot.data[0]['name'];
                                        }
                                        return DropdownButton<String>(
                                            value: _recipes[2][index],
                                            items: snapshot.data
                                                .map<
                                                DropdownMenuItem<
                                                    String>>((value) =>
                                            new DropdownMenuItem<
                                                String>(
                                              value: value['name'],
                                              child: new Text(
                                                  value['name']),
                                            ))
                                                .toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                _recipes[2][index] = newValue;
                                              });
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }));
                          },
                          itemCount: 7)
                  )),
              //Lunch Step
            ],
            type: StepperType.horizontal,
            currentStep: this._currentStep,
            onStepContinue: () {
              setState(() {
                if (this._currentStep < 2) {
                  if (_formKeys[_currentStep].currentState.validate()) {
                    _formKeys[_currentStep].currentState.save();
                    this._currentStep = this._currentStep + 1;
                  }
                } else {
                  //Save data from all the forms
                  if (_formKeys[_currentStep].currentState.validate()) {
                    _formKeys[_currentStep].currentState.save();
                    saveCalendar(_recipes);
                  }
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (this._currentStep > 0) {
                  this._currentStep = this._currentStep - 1;
                } else {
                  this._currentStep = 0;
                }
              });
            }));
  }
}
