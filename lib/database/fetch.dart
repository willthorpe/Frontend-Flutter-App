import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

Future<List> fetchActiveCalendar() async {
  final Database db = internalDatabase;
  List<Map<String, dynamic>> calendars =
  await db.rawQuery('SELECT * from calendars WHERE active=1 ORDER BY id DESC limit 1');

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

Future<Object> fetchDiets() async {
  final Database db = internalDatabase;
  final diets =
  await db.rawQuery('SELECT * from diets');
  return diets;
}

Future<Object> fetchAllergies() async {
  final Database db = internalDatabase;
  final allergies =
  await db.rawQuery('SELECT * from allergies');
  return allergies;
}

Future<Object> fetchLeftovers() async {
  final Database db = internalDatabase;
  final leftovers =
  await db.rawQuery('SELECT * from leftovers');
  return leftovers;
}

Future<Object> fetchNutrition() async {
  final Database db = internalDatabase;
  final nutrition =
  await db.rawQuery('SELECT * from nutrition');
  return nutrition;
}