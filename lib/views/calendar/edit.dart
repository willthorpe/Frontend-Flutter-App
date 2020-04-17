import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:flutter_app/database/save.dart';
import 'package:flutter_app/globals.dart';

class EditCalendarPage extends StatefulWidget {
  EditCalendarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditCalendarPageState createState() => _EditCalendarPageState();
}

class _EditCalendarPageState extends State<EditCalendarPage> {
  Future _future;
  final _scaffoldCalendarKey = GlobalKey<ScaffoldState>();
  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  int _currentStep = 0;

  //Save the form data
  List _recipes = [
    ['', '', '', '', '', '', ''],
    ['', '', '', '', '', '', ''],
    ['', '', '', '', '', '', '']
  ];

  @override
  void initState() {
    super.initState();
    _future = fetchCalendarRecipes();
  }

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
                                leading: Text(days[index],
                                    style: TextStyle(fontSize: 15.0)),
                                title: FutureBuilder(
                                    future: _future,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data[0].length > 0) {
                                          _recipes[0] =
                                              snapshot.data[0]['breakfast'];
                                        }
                                        if (_recipes[0][index] == '') {
                                          _recipes[0][index] =
                                              snapshot.data[1][0]['name'];
                                        }
                                        return DropdownButton<String>(
                                            value: _recipes[0][index],
                                            items: snapshot.data[1]
                                                .map<DropdownMenuItem<String>>(
                                                    (value) =>
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
                                                print(_recipes);
                                              });
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }));
                          },
                          itemCount: 7))),
              //Lunch step
              Step(
                  isActive: _currentStep >= 1,
                  title: Text('Lunch'),
                  content: new Form(
                      key: _formKeys[1],
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: Text(days[index],
                                    style: TextStyle(fontSize: 15.0)),
                                title: FutureBuilder(
                                    future: _future,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data[0].length > 0) {
                                          _recipes[1] =
                                              snapshot.data[0]['lunch'];
                                        }
                                        if (_recipes[1][index] == '') {
                                          _recipes[1][index] =
                                              snapshot.data[1][0]['name'];
                                        }
                                        return DropdownButton<String>(
                                            value: _recipes[1][index],
                                            items: snapshot.data[1]
                                                .map<DropdownMenuItem<String>>(
                                                    (value) =>
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
                                                print(_recipes);
                                              });
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }));
                          },
                          itemCount: 7))),
              //Dinner step
              Step(
                  isActive: _currentStep >= 2,
                  title: Text('Dinner'),
                  content: new Form(
                      key: _formKeys[2],
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: Text(days[index],
                                    style: TextStyle(fontSize: 15.0)),
                                title: FutureBuilder(
                                    future: _future,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data[0].length > 0) {
                                          _recipes[2] =
                                              snapshot.data[0]['dinner'];
                                        }
                                        if (_recipes[2][index] == '') {
                                          _recipes[2][index] =
                                              snapshot.data[1][0]['name'];
                                        }
                                        return DropdownButton<String>(
                                            value: _recipes[2][index],
                                            items: snapshot.data[1]
                                                .map<DropdownMenuItem<String>>(
                                                    (value) =>
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
                                                print(_recipes);
                                              });
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }));
                          },
                          itemCount: 7))),
              //Lunch Step
            ],
            type: StepperType.horizontal,
            currentStep: this._currentStep,
            controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.orange[300],
                    onPressed: onStepCancel,
                    child: const Text('Previous'),
                  ),
                  RaisedButton(
                    color: Colors.orange[300],
                    onPressed: onStepContinue,
                    child: const Text('Next'),
                  ),
                ],
              );
            },
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
                    print(_recipes);
                    saveCalendar(_recipes, false);
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
