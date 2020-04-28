import 'package:flutter/material.dart';
import 'package:flutter_app/database/save.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:flutter_app/http/save.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quiver/async.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class NextRecipePage extends StatefulWidget {
  NextRecipePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NextRecipePageState createState() => _NextRecipePageState();
}

class _NextRecipePageState extends State<NextRecipePage> {
  Future _future;
  final _scaffoldResultsKey = GlobalKey<ScaffoldState>();
  final _formResultsKey = GlobalKey<FormState>();
  final _formLeftoverKey = GlobalKey<FormState>();
  var _timers = [];
  var _leftovers = 0;
  File _recipeImage;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _recipeImage = image;
    });
  }

  //Setup and initialisation of local notifications adapted from the tutorial https://medium.com/@nitishk72/flutter-local-notification-1e43a353877b
  Future _showNotificationWithDefaultSound(timer) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'notification_channel_id', 'Timer', 'Countdown Timer');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Timer Finished',
        'Timer of $timer seconds elapsed', platformChannelSpecifics);
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //End of setup and initialisation from the tutorial

  @override
  void initState() {
    super.initState();
    _future = fetchNextRecipe();
    //Setup and initialisation of local notifications from the tutorial https://medium.com/@nitishk72/flutter-local-notification-1e43a353877b
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    //End of local notification setup
  }

  Widget build(BuildContext context) {
    return _buildFutureBuilder();
  }

  Widget _buildFutureBuilder() {
    return FutureBuilder(
        future: this._future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data[0].contains("EMPTY") && !snapshot.data[0].contains("LEFTOVER")) {
              return DefaultTabController(
                  length: 5,
                  child: Scaffold(
                      key: this._scaffoldResultsKey,
                      appBar: AppBar(
                          title: Text(snapshot.data[0]["name"]),
                          bottom: TabBar(tabs: [
                            Tab(icon: Icon(Icons.restaurant_menu)),
                            Tab(icon: Icon(Icons.kitchen)),
                            Tab(icon: Icon(Icons.list)),
                            Tab(icon: Icon(Icons.timer)),
                            Tab(icon: Icon(Icons.cached)),
                          ])),
                      body: TabBarView(children: [
                        new Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.timer),
                                title: Text(snapshot.data[0]['tag'].toString()),
                                trailing: Text("Meal Time"),
                              ),
                              ListTile(
                                leading: Icon(Icons.room_service),
                                title: Text(
                                    snapshot.data[0]['servings'].toString()),
                                trailing: Text("Servings"),
                              ),
                              ListTile(
                                leading: Icon(Icons.av_timer),
                                title: Text(
                                    "${snapshot.data[0]['prepTime'].toString()} minutes"),
                                trailing: Text("Prep Time"),
                              ),
                              ListTile(
                                leading: Icon(Icons.alarm),
                                title: Text(
                                    "${snapshot.data[0]['cookTime'].toString()} minutes"),
                                trailing: Text("Cook Time"),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              shrinkWrap: true,
                              itemCount: snapshot.data[0]['ingredients'].length,
                              itemBuilder:
                                  (BuildContext context, int ingredientIndex) {
                                if (snapshot.data[0]["ingredients"]
                                        [ingredientIndex]['measurement'] ==
                                    "number") {
                                  return ListTile(
                                      leading: Icon(Icons.kitchen),
                                      trailing: Text(snapshot.data[0]
                                              ['ingredients'][ingredientIndex]
                                              ['amount']
                                          .toString()),
                                      title: Text(snapshot.data[0]
                                              ['ingredients'][ingredientIndex]
                                          ['name']));
                                } else {
                                  return ListTile(
                                      leading: Icon(Icons.kitchen),
                                      trailing: Text(snapshot.data[0]
                                                  ['ingredients']
                                                  [ingredientIndex]['amount']
                                              .toString() +
                                          " " +
                                          snapshot.data[0]['ingredients']
                                              [ingredientIndex]['measurement']),
                                      title: Text(snapshot.data[0]
                                              ['ingredients'][ingredientIndex]
                                          ['name']));
                                }
                              }),
                        ),
                        new Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              shrinkWrap: true,
                              itemCount: snapshot.data[0]['method'].length,
                              itemBuilder:
                                  (BuildContext context, int methodIndex) {
                                return ListTile(
                                    leading: Icon(Icons.list),
                                    title: Text(snapshot.data[0]['method']
                                        [methodIndex]));
                              }),
                        ),
                        new Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Form(
                              key: this._formResultsKey,
                              child: new ListView(
                                  padding: const EdgeInsets.all(10),
                                  children: <Widget>[
                                    new ListTile(
                                        leading: const Icon(Icons.timer),
                                        title: TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: 'Timer in secs'),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Enter time';
                                              }
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              setState(() {
                                                CountdownTimer countdownTimer =
                                                    CountdownTimer(
                                                        Duration(
                                                            seconds: int.parse(
                                                                value)),
                                                        Duration(seconds: 1));
                                                this
                                                    ._timers
                                                    .add(countdownTimer);
                                                var listener =
                                                    countdownTimer.listen(null);
                                                listener.onData((duration) {
                                                  setState(() {});
                                                });
                                                print(_timers);
                                              });
                                            }),
                                        trailing: RaisedButton(
                                            onPressed: () {
                                              if (this
                                                  ._formResultsKey
                                                  .currentState
                                                  .validate()) {
                                                this
                                                    ._formResultsKey
                                                    .currentState
                                                    .save();
                                                final snackBar = SnackBar(
                                                    content:
                                                        Text("Timer Started"));
                                                this
                                                    ._scaffoldResultsKey
                                                    .currentState
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            color: Colors.orange[300],
                                            child: Text('Create Timer'))),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: this._timers.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (_timers[index]
                                                      .remaining
                                                      .inSeconds ==
                                                  0 &&
                                              _timers.length > 0) {
                                            _showNotificationWithDefaultSound(
                                                (_timers[index]
                                                            .elapsed
                                                            .inSeconds +
                                                        1)
                                                    .toString());
                                            _timers.removeAt(index);
                                          }
                                          return ListTile(
                                              title: Text(_timers[index]
                                                      .remaining
                                                      .inSeconds
                                                      .toString() +
                                                  " seconds"));
                                        }),
                                  ])),
                        ),
                        new Container(
                            child: Form(
                                key: this._formLeftoverKey,
                                child: ListView(
                                  padding: EdgeInsets.all(10),
                                  children: <Widget>[
                                    new ListTile(
                                        leading: const Icon(Icons.redo),
                                        title: TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Number of leftovers'),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Enter value';
                                              }
                                              return null;
                                            },
                                            onSaved: (String value) {
                                              this._leftovers =
                                                  int.parse(value);
                                            })),
                                    ListTile(
                                      leading: const Icon(Icons.add_a_photo),
                                      title: Container(
                                        width: 150,
                                        child: RaisedButton(
                                            onPressed: getImage,
                                            color: Colors.orange[300],
                                            child: Text('Photo')),
                                      ),
                                      trailing: _recipeImage == null
                                          ? Text('No image selected.')
                                          : Image.file(_recipeImage),
                                    ),
                                    Center(
                                      child: RaisedButton(
                                          onPressed: () {
                                            if (this
                                                ._formLeftoverKey
                                                .currentState
                                                .validate()) {
                                              this
                                                  ._formLeftoverKey
                                                  .currentState
                                                  .save();
                                              saveLeftovers(
                                                  snapshot.data[0]["name"],
                                                  _leftovers);
                                              updateIngredients(snapshot.data[0]
                                                  ['ingredients']);
                                              final snackBar = SnackBar(
                                                  content: Text("Processing"));
                                              this
                                                  ._scaffoldResultsKey
                                                  .currentState
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                          color: Colors.orange[300],
                                          child: Text('Mark as Made')),
                                    ),
                                  ],
                                )))
                      ])));
            } else {
              return Scaffold(
                key: this._scaffoldResultsKey,
                appBar: AppBar(
                  title: Text(snapshot.data[0]),
                ),
                body: Center(
                  child: Text("The meal is " + snapshot.data[0]),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
