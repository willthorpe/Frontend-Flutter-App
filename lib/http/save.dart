import 'package:flutter_app/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Save Ingredient within the recipe database
Future<String> saveIngredient(String name, int amount, String type,
    String location) async {
  var response = await http.post(url + "/ingredient", body: {
    'user': user.uid,
    'name': name,
    'amount': amount.toString(),
    'type': type,
    'location': location,
  });

  //Valid response from the API so display "saved" on the screen
  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
    return "Saved";
  } else {
    //Failed, display error
    print("Request failed with status: ${response.statusCode}.");
    return "Error : ${response.statusCode}";
  }
}

//Edit Ingredient within the recipe database
Future<String> editIngredient(String name, int amount, String type,
    String location) async {
  var response = await http.patch(url + "/ingredient",
      body: {'user': user.uid, 'name': name, 'amount':amount.toString(), 'type':type, 'location':location});


  //Valid response from the API so display "saved" on the screen
  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
    return "Saved";
  } else {
    //Failed, display error
    print("Request failed with status: ${response.statusCode}.");
    return "Error : ${response.statusCode}";
  }
}

Future<String> saveRecipe(String name, String tag, int servings,
    int prepTime, int cookTime, ingredients, methods) async {
  var response = await http.post(url + "/recipe", body: {
    'user': user.uid,
    'name': name,
    'tag': tag,
    'servings': servings.toString(),
    'prepTime': prepTime.toString(),
    'cookTime': cookTime.toString(),
    'ingredients': json.encode(ingredients),
    'methods': json.encode(methods)
  });

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
    return "Saved";
  } else {
    print("Request failed with status: ${response.statusCode}.");
    return "Error : ${response.statusCode}";
  }
}

//Edit Ingredient within the recipe database
Future<String> editRecipeSummary(String name, String tag, int servings,
    int prepTime, int cookTime) async {
  var response = await http.patch(url + "/recipe/summary",
      body: {'user': user.uid, 'name':name, 'tag': tag, 'servings':servings.toString(), 'prepTime':prepTime.toString(), 'cookTime':cookTime.toString()});


  //Valid response from the API so display "saved" on the screen
  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
    return "Saved";
  } else {
    //Failed, display error
    print("Request failed with status: ${response.statusCode}.");
    return "Error : ${response.statusCode}";
  }
}

Future<String> createLink(String recipe, ingredients) async {
  var response = await http.post(url + "/link", body: {
    'user': user.uid,
    'recipe': recipe,
    'ingredients': json.encode(ingredients)
  });

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<String> saveShoppingList(purchased) async {
  var response = await http.patch(url + "/recipe",
      body: {'user': user.uid, 'purchased': json.encode(purchased)});

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

Future<String> updateIngredients(ingredients) async {
  var response = await http.patch(url + "/ingredient/amount",
      body: {'user': user.uid, 'ingredients': json.encode(ingredients)});

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}
