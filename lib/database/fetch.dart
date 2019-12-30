import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

Future <Object> fetchCalendar() async {
  final Database db = internalDatabase;
  final calendar = await db.rawQuery('SELECT * from calendars ORDER BY id DESC limit 1');
  return calendar;
}

Future <Object> fetchSettings() async {
  final Database db = internalDatabase;
  List<Map<String, dynamic>> settings = await db.rawQuery('SELECT * from settings');

  return List.generate(
    settings.length, (index){
      return {
        'id': settings[index]['id'],
        'name': settings[index]['name'],
        'value': settings[index]['value']
      };
  }
  );
}