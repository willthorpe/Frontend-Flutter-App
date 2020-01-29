import 'package:flutter/material.dart';
import '../globals.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scaffoldSearchKey = GlobalKey<ScaffoldState>();
  final _formSearchKey = GlobalKey<FormState>();

  //Save the form data
  List<double> _sliders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldSearchKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
          key: _formSearchKey,
          child: Column(children: <Widget>[
            new ListView.separated(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: searchParameters.length,
              itemBuilder: (context, index) {
                _sliders.add(5.0);
                return
                  ListTile(
                    title: Center(child: Text(
                      searchParameters[index],
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
                    subtitle: Slider(
                        activeColor: Colors.lightGreen,
                        min: 0,
                        max: 10,
                        divisions: 11,
                        onChanged: (rating) {
                          setState(() => _sliders[index] = rating);
                        },
                        value: _sliders[index]),
                  );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
            Center(
              child: RaisedButton(
                  onPressed: () {
                    if (_formSearchKey.currentState.validate()) {
                      _formSearchKey.currentState.save();
                      //search();
                      final snackBar =
                      SnackBar(content: Text("Processing"));
                      _scaffoldSearchKey.currentState
                          .showSnackBar(snackBar);
                    }
                  },
                  child: Text('Save')),
            ),
          ],
          ),
    ));
  }
}
