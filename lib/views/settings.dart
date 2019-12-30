import 'package:flutter/material.dart';
import '../database/save.dart';
import '../database/fetch.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _scaffoldSettingsKey = GlobalKey<ScaffoldState>();
  final _formSettingsKey = GlobalKey<FormState>();
  List _preferences = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldSettingsKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
            key: _formSettingsKey,
            child: Column(children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: FutureBuilder(
                      future: fetchSettings(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if(_preferences.length == 0){
                            _preferences = snapshot.data;
                          }
                          return new ListView.separated(
                            itemCount: _preferences.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new SwitchListTile(
                                  title: Text(_preferences[index]['name']),
                                  value: _preferences[index]['value'].isOdd,
                                  onChanged: (bool value) {
                                    setState(() {
                                      print(value);
                                      if(value == true){
                                        _preferences[index]['value'] = 1;
                                        print(_preferences);
                                      }else{
                                        _preferences[index]['value'] = 0;
                                      }
                                    });
                                  });
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
                      })),
              Center(
                child: RaisedButton(
                    onPressed: () {
                      if (_formSettingsKey.currentState.validate()) {
                        _formSettingsKey.currentState.save();
                        saveSettings(_preferences);
                        final snackBar = SnackBar(content: Text("Processing"));
                        _scaffoldSettingsKey.currentState
                            .showSnackBar(snackBar);
                      }
                    },
                    child: Text('Save')),
              ),
            ])));
  }
}
