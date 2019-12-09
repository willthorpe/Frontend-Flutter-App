import 'dart:convert';
import '../globals.dart';
import 'package:http/http.dart' as http;

String url = "http://127.0.0.1:3000";

Future<List> fetchIngredients() async {
  var response = await http.post(url + "/ingredient", body: {
    'user': user.uid,
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<List> fetchRecipes() async {
  var response = await http.post(url + "/recipe", body: {
    'user': user.uid,
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}