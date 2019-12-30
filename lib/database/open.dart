import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

Future setupDatabase() async {
  print("setup database");
  final database = openDatabase(
    join(await getDatabasesPath(), 'recipe_database3.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      print("db created");
      db.execute(
        "CREATE TABLE calendars(id INTEGER PRIMARY KEY AUTOINCREMENT, breakfast TEXT, lunch TEXT, dinner TEXT)"
      );
      db.execute(
        "CREATE TABLE settings(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value int)",
      );
      for(var i =0; i<settings.length; i++){
        db.insert(
          'settings',
          {
            'name': settings[i],
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