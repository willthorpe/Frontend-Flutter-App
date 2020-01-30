import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

FirebaseUser user;
Database internalDatabase;
String url = "http://52.56.185.203:3000";

List menuItems = [
  'Ingredients',
  'Recipe Book',
  'Search',
  'Recipe Calendar',
  'Shopping List',
  'Add Ingredient',
  'Add Recipe',
  'Settings'
];

List<String> ingredientTypes = [
  'grams',
  'oz',
  'millilitres',
  'teaspoons',
  'tablespoons',
  'number',
  'cups',
];

List<String> recipeTags = [
  'Breakfast',
  'Brunch',
  'Lunch',
  'Main Meal',
  'Dinner'
];

List<String> settings = [
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
  'Balanced Diet',
  'High-Fibre Diet',
  'High-Protein Diet',
  'Low-Carb Diet',
  'Low-Fat Diet',
  'Low-Sodium Diet'
];

List<String> searchParameters = [
  'Prefer Owned Ingredients',
  'Prefer Lighter Weight',
  'Prefer Variety',
  'Prefer Popular Recipes',
  'Prefer Less Ingredients'
];