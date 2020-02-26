import 'dart:core';
import 'package:googleapis/calendar/v3.dart';
import 'package:flutter_app/globals.dart';

Future<List> fetchGoogleCalendars() async {
  var results = await CalendarApi(httpClient).calendarList.list();
  FreeBusyRequest freeBusy = new FreeBusyRequest();
  freeBusy.timeMin = new DateTime.utc(2020, 2, 26);
  freeBusy.timeMax = new DateTime.utc(2020, 2, 27);
  freeBusy.items = [];
  for (var i in results.items) {
    FreeBusyRequestItem item = new FreeBusyRequestItem();
    item.id = i.id;
    freeBusy.items.add(item);
  }
  var freeBusyResponse = await CalendarApi(httpClient).freebusy.query(freeBusy);
  var collatedTimes = [];
  for (var j in freeBusyResponse.calendars.keys) {
    if (freeBusyResponse.calendars[j].busy.length > 0) {
      for (var k in freeBusyResponse.calendars[j].busy) {
        collatedTimes.add(k.toJson());
      }
    }
  }
  collatedTimes.sort((left, right) {
    return left['start'].compareTo(right['start']);
  });

  print(collatedTimes);
}
