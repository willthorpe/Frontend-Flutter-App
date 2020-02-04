import 'package:flutter_app/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future <String> saveIngredient(String name, String amount, String type, String location, DateTime useByDate) async {
  var useBy = useByDate.toString();


  var response = await http.post(url + "/ingredient", body: {
    'user': user.uid,
    'name': name,
    'amount': amount,
    'type' : type,
    'location': location,
    'useByDate' : useBy.split(" ")[0]
  });

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future <String> saveRecipe(String name, String tag, String servings, String prepTime,String cookTime, ingredients,methods) async {
  var response = await http.post(url + "/recipe", body: {
    'user': user.uid,
    'name': name,
    'tag': tag,
    'servings': servings,
    'prepTime' : prepTime,
    'cookTime': cookTime,
    'ingredients' : json.encode(ingredients),
    'methods' : json.encode(methods)
  });

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future <String> saveShoppingList(purchased) async {
  var response = await http.patch(url + "/recipe", body: {
    'user': user.uid,
    'purchased' : json.encode(purchased)
  });

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}