import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/globals.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldLoginKey = GlobalKey<ScaffoldState>();
  final _formLoginKey = GlobalKey<FormState>();
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
                        _signInGoogle(context);
                      },
                      color: Colors.orange[300],
                      child: Text("Login with Google")),
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
                      color: Colors.orange[300],
                      child: Text('Login')),
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,'/register');
                      },
                      color: Colors.orange[300],
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

//Günter Zöchbauer
//https://stackoverflow.com/questions/48477625/how-to-use-google-api-in-flutter
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

Future <String> _signInGoogle(context) async {
  final GoogleSignInAccount googleUser = await GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/calendar.readonly',
      'https://www.googleapis.com/auth/calendar.events.readonly'
    ],
  ).signIn();
  final GoogleSignInAuthentication googleAuth =
  await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final FirebaseUser user =
      (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  assert(user.email != null);
  assert(user.displayName != null);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  var authHeaders = await googleUser.authHeaders;
  httpClient = GoogleHttpClient(authHeaders);

  firebaseResult(currentUser, context);
}

firebaseResult(returnedUser, context){
  user = returnedUser;
  Navigator.pushNamed(context,'/home');
}