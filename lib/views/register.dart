import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/globals.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _scaffoldRegisterKey = GlobalKey<ScaffoldState>();
  final _formRegisterKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  //Save the form data
  String _email = '';
  String _password = '';

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
                new ListTile(
                  leading: const Icon(Icons.email),
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
                        if (_formRegisterKey.currentState.validate()) {
                          _formRegisterKey.currentState.save();
                          signInUser(_email, _password, context);
                          final snackBar =
                              SnackBar(content: Text("Processing"));
                          _scaffoldRegisterKey.currentState
                              .showSnackBar(snackBar);
                        }
                      },
                      color: Colors.orange[300],
                      child: Text('Register')),
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,'/');
                      },
                      color: Colors.orange[300],
                      child: Text("Already have an account?")),
                ),
              ]),
        ));
  }
}

Future <String> signInUser(String email, String password, context) async {
  try {
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
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