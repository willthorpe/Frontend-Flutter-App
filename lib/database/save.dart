import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

Future saveCalendar(List recipes) async {
  final Database db = internalDatabase;
  await db.insert(
    'calendars',
    {
      'breakfast': json.encode(recipes[0]),
      'lunch': json.encode(recipes[1]),
      'dinner': json.encode(recipes[2]),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future saveSettings(List preferences) async {
  final Database db = await internalDatabase;
  for (var i = 0; i < preferences.length; i++) {
    if (preferences[i]['type'] == 'allergy') {
      db.update(
        'allergies',
        {
          'name': preferences[i]['name'],
          'value': preferences[i]['value'],
        },
        where: 'id=?',
        whereArgs: [preferences[i]['id']],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      db.update(
        'diets',
        {
          'name': preferences[i]['name'],
          'value': preferences[i]['value'],
        },
        where: 'id=?',
        whereArgs: [preferences[i]['id']],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
