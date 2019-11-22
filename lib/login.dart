import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/globals.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldLoginKey = GlobalKey<ScaffoldState>();
  final _formLoginKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  //Save the form data
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldLoginKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formLoginKey,
          child: new ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.people),
                  title: TextFormField(
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        this._email = value;
                      }),
                ),
                new ListTile(
                  leading: const Icon(Icons.lock),
                  title: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        this._password = value;
                      }),
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        if (_formLoginKey.currentState.validate()) {
                          _formLoginKey.currentState.save();
                         loginUser(_email,_password, context);
                          final snackBar =
                              SnackBar(content: Text("Processing"));
                          _scaffoldLoginKey.currentState
                              .showSnackBar(snackBar);
                        }
                      },
                      child: Text('Login')),
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,'/register');
                      },
                      child: Text("Don't have an account?")),
                ),
              ]),
        ));
  }
}

Future <String> loginUser(String email, String password, context) async {
  try {
    var result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    firebaseResult(result.user, context);
    return "true";
  }  catch (e) {
    throw new AuthException(e.code, e.message);
  }
}

firebaseResult(returnedUser, context){
  user = returnedUser;
  Navigator.pushNamed(context,'/home');
}