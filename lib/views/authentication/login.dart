import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/globals.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:flutter_app/views/authentication/common.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldLoginKey = GlobalKey<ScaffoldState>();
  final _formLoginKey = GlobalKey<FormState>();

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
                //Fetch email tile from common.dart
                createEmailTile(),
                //Fetch password tile from common.dart
                createPasswordTile(),
                //Google signin button
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        signInGoogle(context);
                      },
                      color: Colors.orange[300],
                      child: Text("Login with Google")),
                ),
                //Email/Password sign in button
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        //Validate and save form
                        if (_formLoginKey.currentState.validate()) {
                          _formLoginKey.currentState.save();
                          authenticateUser(email, password, context, 'login');
                          final snackBar =
                              SnackBar(content: Text("Logging In"));
                          _scaffoldLoginKey.currentState.showSnackBar(snackBar);
                        }
                      },
                      color: Colors.orange[300],
                      child: Text('Login')),
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      color: Colors.orange[300],
                      child: Text("Don't have an account?")),
                ),
              ]),
        ));
  }
}

//Custom implementation of HTTP Client from Stack Overflow
//Author: Günter Zöchbauer https://stackoverflow.com/users/217408/günter-zöchbauer
//Post: https://stackoverflow.com/questions/48477625/how-to-use-google-api-in-flutter
class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}
//End of custom implementation of HTTP client from Stack Overflow

Future signInGoogle(context) async {
  //Choose the scopes for the project - it requires calendar permissions
  final GoogleSignInAccount googleUser = await GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/calendar.readonly',
      'https://www.googleapis.com/auth/calendar.events.readonly'
    ],
  ).signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final FirebaseUser user =
      (await FirebaseAuth.instance.signInWithCredential(credential)).user;

  //This Http client allows the use of the calendar api in the apis folder
  var authHeaders = await googleUser.authHeaders;
  httpClient = GoogleHttpClient(authHeaders);

  //Return the logged in user
  firebaseResult(user, context);
}