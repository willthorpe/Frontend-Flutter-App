import 'package:flutter/cupertino.dart';
import 'package:flutter_app/globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//POST

/**
 * POST ingredient to the database
 */
Future<String> saveIngredient(String name, int amount, String measurement,
    String location) async {
  var response = await http.post(url + "/ingredient", body: {
    'user': user.uid,
    'name': name,
    'amount': amount.toString(),
    'measurement': measurement,
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

/**
 * POST recipe to the database
 */
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

/**
 * POST link between ingredients and recipes
 */
Future<String> createLink(String recipe, ingredients) async {
  var response = await http.post(url + "/recipe/link", body: {
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

//PATCH

/**
 * Edit Ingredient within the recipe database
 */
Future<String> editIngredient(String name, int amount, String measurement,
    String location) async {
  var response = await http.patch(url + "/ingredient",
      body: {'user': user.uid, 'name': name, 'amount':amount.toString(), 'measurement':measurement, 'location':location});


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

/**
 * PATCH recipe summary
 */
Future<String> editRecipeSummary(String name, String tag, int servings,
    int prepTime, int cookTime) async {
  var response = await http.patch(url + "/recipe/summary",
      body: {
        'user': user.uid,
        'name': name,
        'tag': tag,
        'servings': servings.toString(),
        'prepTime': prepTime.toString(),
        'cookTime': cookTime.toString()
      });
}

/**
 * PATCH recipe ingredients
 */

Future<String> editRecipeIngredients(String name, ingredients) async {

  var response = await http.patch(url + "/recipe/ingredients",
      body: {'user': user.uid, 'name':name, 'ingredients':json.encode(ingredients)});
}

/**
 * PATCH recipe method
 */
  Future<String> editRecipeMethod(String name, method) async {

    var response = await http.patch(url + "/recipe/method",
        body: {'user': user.uid, 'name':name, 'method':json.encode(method)});
}

/**
 * PATCH Save/Update shopping list
 */
Future<String> saveShoppingList(purchased) async {
  print(purchased);
  var response = await http.patch(url + "/list",
      body: {'user': user.uid, 'purchased': json.encode(purchased)});

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}

/**
 * Update Shopping List Ingredients
 */
Future<String> updateIngredients(ingredients) async {
  print(ingredients);
  var response = await http.patch(url + "/ingredient/amount",
      body: {'user': user.uid, 'ingredients': json.encode(ingredients)});

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }
}
