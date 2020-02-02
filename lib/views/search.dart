import 'package:flutter/material.dart';
import '../globals.dart';
import 'package:flutter_app/http/fetch.dart';

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
          child: Column(
            children: <Widget>[
              new Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: searchParameters.length,
                    itemBuilder: (context, index) {
                      _sliders.add(0.5);
                      return ListTile(
                        title: Center(
                            child: Text(
                          searchParameters[index],
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        )),
                        subtitle: Slider(
                            activeColor: Colors.lightGreen,
                            min: 0,
                            max: 1,
                            divisions: 20,
                            onChanged: (rating) {
                              setState(() => _sliders[index] = rating);
                            },
                            value: _sliders[index]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  )),
              Center(
                child: RaisedButton(
                    onPressed: () {
                      if (_formSearchKey.currentState.validate()) {
                        _formSearchKey.currentState.save();
                        Navigator.pushNamed(context, '/searchresults',
                            arguments: {
                              'title': "Results",
                              'data': _sliders
                            });

                        final snackBar = SnackBar(content: Text("Processing"));
                        _scaffoldSearchKey.currentState.showSnackBar(snackBar);
                      }
                    },
                    child: Text('Search')),
              ),
            ],
          ),
        ));
  }
}
