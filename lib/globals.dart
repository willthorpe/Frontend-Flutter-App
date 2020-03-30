import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

FirebaseUser user;
var httpClient = null;
Database internalDatabase;
String url = "http://3.10.20.105:3000";

List menuItems = [
  'Next Recipe',
  'Create Ingredient',
  'Create Recipe',
  'Larder',
  'Recipe Book',
  'Recipe Calendar',
  'Shopping List',
  'Search',
  'Nutrition Goals',
  'Graphs',
  'Settings'
];

List<String> ingredientTypes = [
  'grams',
  'ounces',
  'millilitres',
  'teaspoons',
  'tablespoons',
  'number',
  'cups',
  'servings'
];

List<String> recipeTags = [
  'Breakfast',
  'Brunch',
  'Lunch',
  'Main Meal',
  'Dinner'
];

List<String> diets = [
  'Balanced Diet',
  'High-Fibre Diet',
  'High-Protein Diet',
  'Low-Carb Diet',
  'Low-Fat Diet',
  'Low-Sodium Diet'
];

List <String> allergies = [
  'Alcohol-Free',
  'Celery-Free',
  'Crustcean-Free',
  'Dairy',
  'Eggs',
  'Fish',
  'FODMAP Free',
  'Gluten',
  'Keto',
  'Kidney Friendly',
  'Kosher',
  'Low Potassium',
  'Lupine Free',
  'Mustard Free',
  'Low Fat',
  'No Oil Added',
  'No Sugar',
  'Paleo',
  'Peanuts',
  'Pescatarian',
  'Pork Free',
  'Red meat Free',
  'Sesame Free',
  'Shellfish',
  'Soy',
  'Sugar-conscious',
  'Tree Nuts',
  'Vegan',
  'Vegetarian',
  'Wheat Free',
];

List<String> searchParameters = [
  'Prefer Owned Ingredients',
  'Prefer Lighter Weight',
  'Prefer Variety',
  'Prefer Popular Recipes',
  'Prefer Less Ingredients',
  'Prefer Less Complex Recipes',
  'Prefer Shorter Recipes',
  'Prefer Matching Diet',
];

final days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];