import 'dart:convert';
import '../globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/database/fetch.dart';

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

Future<List> fetchShoppingList() async {
  var calendar = await fetchCalendar();
  var response = await http.post(url + "/list", body: {
    'user': user.uid,
    'calendar':calendar.toString()
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}