import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

Future <Object> fetchCalendar() async {
  final Database db = internalDatabase;
  final calendar = await db.rawQuery('SELECT * from calendars ORDER BY id DESC limit 1');
  return calendar;
}