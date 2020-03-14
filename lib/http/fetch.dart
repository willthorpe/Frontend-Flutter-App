import 'dart:convert';
import 'dart:core';
import '../globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/database/fetch.dart';
import '../apis/google.dart';

Future<List> fetchIngredients() async {
  var response = await http.get(url + "/ingredient?user=" + user.uid);
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<List> fetchRecipes() async {
  var leftovers = await fetchLeftovers();
  var response = await http.get(url + "/recipe?user=" + user.uid);
  if (response.statusCode == 200) {
    return json.decode(response.body) + leftovers;
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<List> fetchCalendarRecipes() async {
  var calendar = await fetchActiveCalendar();
  var leftovers = await fetchLeftovers();
  var response = await http.get(url + "/recipe?user=" + user.uid);
  if (response.statusCode == 200) {
    return [calendar[0], json.decode(response.body) + leftovers];
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<List> fetchShoppingList() async {
  var calendar = await fetchActiveCalendar();
  var response = await http.get(
      url + "/list?user=" + user.uid + "&calendar=" + json.encode(calendar));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<List> fetchSearchResults(sliders) async {
  var diets = await fetchDiets();
  var allergies = await fetchAllergies();
  List parameters = [];
  for (var i = 0; i < searchParameters.length; i++) {
    parameters.add(sliders[i]);
  }
  var response = await http.get(url +
      "/search?user=" +
      user.uid +
      "&search=" +
      json.encode(parameters) +
      "&allergies=" +
      json.encode(allergies) +
      "&diets=" +
      json.encode(diets));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<List> fetchNextRecipe() async {
  var calendar = await fetchActiveCalendar();
  var now = new DateTime.now();
  var day = now.weekday;
  var nextMeal = null;

  if (now.hour < 12){
    //Breakfast
    nextMeal = calendar[0]["breakfast"][day+1];
  }else if(now.hour <= 14 && now.hour >= 12){
    //Lunch
    nextMeal = calendar[0]["lunch"][day+1];
  }else{
    //Dinner
    nextMeal = calendar[0]["dinner"][day+1];
  }

  var response = await http.get(url + "/next?user=" + user.uid + "&recipe=" + nextMeal);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<List> automateCalendar(breakfast, lunch, dinner, weekFrequency) async {
  var busy = await fetchGoogleCalendars();
  var response = await http.get(url +
      "/automate?user=" +
      user.uid +
      "&breakfast=" +
      json.encode(breakfast) +
      "&lunch=" +
      json.encode(lunch) +
      "&dinner=" +
      json.encode(dinner) +
      "&week=" +
      json.encode(weekFrequency) +
      "&busy=" +
      json.encode(busy)
  );
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}