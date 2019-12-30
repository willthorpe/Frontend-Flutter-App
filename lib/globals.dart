import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

FirebaseUser user;
Database internalDatabase;
String url = "http://127.0.0.1:3000";

List menuItems = [
  'Stockroom',
  'Recipe Book',
  'Recipe Calendar',
  'Shopping List',
  'Add Ingredient',
  'Add Recipe',
];

List<String> ingredientTypes = [
  'grams',
  'millilitres',
  'teaspoons',
  'tablespoons',
  'number',
];

List<String> recipeTags = [
  'Breakfast',
  'Brunch',
  'Lunch',
  'Main Meal',
  'Dinner'
];

