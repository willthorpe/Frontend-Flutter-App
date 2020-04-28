import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

/**
 * Fetch the currently used calendar for this week
 */
Future<List> fetchActiveCalendar() async {
  final Database db = internalDatabase;
  List<Map<String, dynamic>> calendars = await db.rawQuery(
      'SELECT * from calendars WHERE active=1 ORDER BY id DESC limit 1');

  var calendar = List.generate(calendars.length, (index) {
    return {
      'id': calendars[index]['id'],
      'breakfast': json.decode(calendars[index]['breakfast']),
      'lunch': json.decode(calendars[index]['lunch']),
      'dinner': json.decode(calendars[index]['dinner']),
      'active': calendars[index]['active']
    };
  });
  return calendar;
}

/**
 * Fetch all calendars in the app
 */
Future<List> fetchCalendars() async {
  final Database db = internalDatabase;
  List<Map<String, dynamic>> calendars =
      await db.rawQuery('SELECT * from calendars ORDER BY id DESC');

  var calendar = List.generate(calendars.length, (index) {
    return {
      'id': calendars[index]['id'],
      'breakfast': json.decode(calendars[index]['breakfast']),
      'lunch': json.decode(calendars[index]['lunch']),
      'dinner': json.decode(calendars[index]['dinner']),
      'active': calendars[index]['active']
    };
  });
  return calendar;
}

/**
 * Fetch all user settings from the app
 */
Future<Object> fetchSettings() async {
  final Database db = internalDatabase;
  List<Map<String, dynamic>> allergies =
      await db.rawQuery('SELECT * from allergies');
  List<Map<String, dynamic>> diets = await db.rawQuery('SELECT * from diets');

  var allergyList = List.generate(allergies.length, (index) {
    return {
      'id': allergies[index]['id'],
      'name': allergies[index]['name'],
      'value': allergies[index]['value'],
      'type': 'allergy'
    };
  });

  var dietList = List.generate(diets.length, (index) {
    return {
      'id': diets[index]['id'],
      'name': diets[index]['name'],
      'value': diets[index]['value'],
      'type': 'diet'
    };
  });
  return allergyList + dietList;
}

/**
 * Fetch all diets
 */
Future<Object> fetchDiets() async {
  final Database db = internalDatabase;
  final diets = await db.rawQuery('SELECT * from diets');
  return diets;
}

/**
 * Fetch all allergies
 */
Future<Object> fetchAllergies() async {
  final Database db = internalDatabase;
  final allergies = await db.rawQuery('SELECT * from allergies');
  return allergies;
}

/**
 * Fetch all leftovers
 */
Future<Object> fetchLeftovers() async {
  final Database db = internalDatabase;
  final leftovers = await db.rawQuery('SELECT * from leftovers where amount > 0');
  return leftovers;
}

/**
 * Fetch leftovers for a specific recipe
 */
Future<Object> fetchLeftoversForRecipe(recipe) async {
  final Database db = internalDatabase;
  List<Map> leftoverList =
      await db.query('leftovers', where: 'name = ?', whereArgs: ["LEFTOVER " + recipe]);

  var leftover = List.generate(leftoverList.length, (index) {
    return {
      'amount': leftoverList[index]['amount'],
    };
  });

  if(leftover.length == 0){
    return 0;
  }else{
    return leftover[0]['amount'];
  }
}