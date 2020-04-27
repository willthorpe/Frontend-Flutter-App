import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

Future saveCalendar(List recipes, active) async {
  final Database db = internalDatabase;
  await db.insert(
    'calendars',
    {
      'breakfast': json.encode(recipes[0]),
      'lunch': json.encode(recipes[1]),
      'dinner': json.encode(recipes[2]),
      'active': active
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future saveAutomateCalendar(List recipes) async {
  var breakfast = [];
  var lunch = [];
  var dinner = [];

  //Convert from days into meal organisation
  for(var i = 0; i<recipes.length - 1; i++){
    breakfast.add(recipes[i]['breakfast']);
    lunch.add(recipes[i]['lunch']);
    dinner.add(recipes[i]['dinner']);
  }

  final Database db = internalDatabase;

  await db.insert(
    'calendars',
    {
      'breakfast': json.encode(breakfast),
      'lunch': json.encode(lunch),
      'dinner': json.encode(dinner),
      'active': false
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future saveActiveCalendar(activeID) async {
  final Database db = internalDatabase;
  await db.update(
    'calendars',
    {
      'active': false,
    },
    where: 'active=?',
    whereArgs: [true],
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  await db.update(
    'calendars',
    {
      'active': true,
    },
    where: 'id=?',
    whereArgs: [activeID],
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future saveLeftovers(recipe, amount) async {
  final Database db = internalDatabase;
  await db.insert(
    'leftovers',
    {
      'name': "LEFTOVER " + recipe,
      'amount': amount,
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

Future saveNutrition(nutrition) async {
  final Database db = internalDatabase;
  for (var item in nutrition.entries){
    await db.insert(
      'nutrition',
      {
        'name': item.key,
        'value': item.value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}