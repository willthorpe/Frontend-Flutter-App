import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/globals.dart';

Future saveCalendar(List recipes) async {
  final Database db = internalDatabase;
  await db.insert(
    'calendars',
    {
      'breakfast':recipes[0].toString(),
      'lunch' : recipes[1].toString(),
      'dinner': recipes[2].toString(),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}