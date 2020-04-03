import 'package:flutter/material.dart';
import 'package:flutter_app/views/authentication/common.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _scaffoldRegisterKey = GlobalKey<ScaffoldState>();
  final _formRegisterKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldRegisterKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formRegisterKey,
          child: new ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
            //Fetch email tile from common.dart
            createEmailTile(),
            //Fetch password tile from common.dart
            createPasswordTile(),
            Center(
              child: RaisedButton(
                  onPressed: () {
                    //Save form state and register the user
                    if (_formRegisterKey.currentState.validate()) {
                      _formRegisterKey.currentState.save();
                      authenticateUser(email, password, context, 'register');
                      final snackBar = SnackBar(content: Text("Registering"));
                      _scaffoldRegisterKey.currentState.showSnackBar(snackBar);
                    }
                  },
                  color: Colors.orange[300],
                  child: Text('Register')),
            ),
            Center(
              child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  color: Colors.orange[300],
                  child: Text("Already have an account?")),
            ),
          ]),
        ));
  }
}