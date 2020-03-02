import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

Future setupDatabase() async {
  print("setup database");
  final database = openDatabase(
    join(await getDatabasesPath(), 'recipe_database4.db'),
    onCreate: (db, version) {
      print("db created");
      db.execute(
        "CREATE TABLE calendars(id INTEGER PRIMARY KEY AUTOINCREMENT, breakfast TEXT, lunch TEXT, dinner TEXT)"
      );
      db.execute(
        "CREATE TABLE diets(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value int)",
      );
      db.execute(
        "CREATE TABLE allergies(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value int)",
      );
      db.execute(
        "CREATE TABLE leftovers(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount int)",
      );
      db.execute(
        "CREATE TABLE nutrition(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value int)",
      );
      for(var i =0; i<diets.length; i++){
        db.insert(
          'diets',
          {
            'name': diets[i],
            'value': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      for(var i =0; i<allergies.length; i++){
        db.insert(
          'allergies',
          {
            'name': allergies[i],
            'value': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  internalDatabase = await database;
}