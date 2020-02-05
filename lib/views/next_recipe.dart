import 'package:flutter/material.dart';
import 'package:flutter_app/http/fetch.dart';
import 'package:quiver/async.dart';

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
  var _timers = [];

  @override
  void initState() {
    super.initState();
    _future = fetchNextRecipe();
  }

  Widget build(BuildContext context) {
    return _buildFutureBuilder();
  }

  Widget _buildFutureBuilder() {
    return FutureBuilder(
        future: this._future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DefaultTabController(
                length: 4,
                child: Scaffold(
                    key: this._scaffoldResultsKey,
                    appBar: AppBar(
                        title: Text(snapshot.data[0]["name"]),
                        bottom: TabBar(tabs: [
                          Tab(icon: Icon(Icons.note_add)),
                          Tab(icon: Icon(Icons.fastfood)),
                          Tab(icon: Icon(Icons.subject)),
                          Tab(icon: Icon(Icons.timer)),
                        ])),
                    body: TabBarView(children: [
                      new Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                  "Servings: " + snapshot.data[0]['servings']),
                            ),
                            ListTile(
                              title: Text("Tag: " + snapshot.data[0]['tag']),
                            ),
                            ListTile(
                              title: Text(
                                  "Prep Time: " + snapshot.data[0]['prepTime']),
                            ),
                            ListTile(
                              title: Text(
                                  "Cook Time: " + snapshot.data[0]['cookTime']),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data[0]['ingredients'].length,
                            itemBuilder:
                                (BuildContext context, int ingredientIndex) {
                              if (snapshot.data[0]["ingredients"]
                                      [ingredientIndex]['type'] ==
                                  "number") {
                                return ListTile(
                                    subtitle: Text(snapshot.data[0]
                                                ['ingredients'][ingredientIndex]
                                            ['amount']
                                        .toString()),
                                    title: Text(snapshot.data[0]['ingredients']
                                        [ingredientIndex]['name']));
                              } else {
                                return ListTile(
                                    subtitle: Text(snapshot.data[0]
                                                    ['ingredients']
                                                [ingredientIndex]['amount']
                                            .toString() +
                                        " " +
                                        snapshot.data[0]['ingredients']
                                            [ingredientIndex]['type']),
                                    title: Text(snapshot.data[0]['ingredients']
                                        [ingredientIndex]['name']));
                              }
                            }),
                      ),
                      new Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data[0]['method'].length,
                            itemBuilder:
                                (BuildContext context, int methodIndex) {
                              return ListTile(
                                  title: Text(
                                      snapshot.data[0]['method'][methodIndex]));
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
                                              hintText: 'Timer'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter time';
                                            }
                                            return null;
                                          },
                                          onSaved: (String value) {
                                            setState(() {
                                              CountdownTimer countdownTimer = CountdownTimer(Duration(minutes:int.parse(value)),Duration(seconds:1));
                                              this._timers.add(
                                                  countdownTimer
                                              );
                                              var listener = countdownTimer.listen(null);
                                              listener.onData((duration) {
                                                setState(() {
                                                });
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
                                          child: Text('Create Timer'))),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: this._timers.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                            title: Text(_timers[index].remaining.toString())
                                        );
                                      }),
                                ])),
                      ),
                    ])));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
