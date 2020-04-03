import 'package:flutter_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Store the form data from the authentication screens
String email = '';
String password = '';
final FirebaseAuth auth = FirebaseAuth.instance;

//Create email form tile on authentication pages
createEmailTile() {
  return ListTile(
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
          email = value;
        }),
  );
}

//Create password form tile on authentication pages
createPasswordTile() {
  return ListTile(
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
          password = value;
        }),
  );
}

//Accept user either allows user login or register depending on the formType
Future <String> authenticateUser(String email, String password, context, formType) async {
  try {
    var result;
    //Contact firebase to login/register the user
    if(formType == "login"){
      result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    }else{
      result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    }
    firebaseResult(result.user, context);
    return "true";
  }  catch (e) {
    throw new AuthException(e.code, e.message);
  }
}

//Save the user in the app and login
firebaseResult(returnedUser, context){
  //Store user globally so can be used in the recipe database
  user = returnedUser;
  Navigator.pushNamed(context,'/home');
}