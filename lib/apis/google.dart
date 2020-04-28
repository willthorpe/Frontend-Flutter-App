import 'dart:core';
import 'package:googleapis/calendar/v3.dart';
import 'package:flutter_app/globals.dart';

Future<List> fetchGoogleCalendars() async {
  var results = await CalendarApi(httpClient).calendarList.list();
  FreeBusyRequest freeBusy = new FreeBusyRequest();

  //Start the calendar search from today until the end of the week
  freeBusy.timeMin = new DateTime.utc(2020, 6, 29);
  freeBusy.timeMin = new DateTime.now().toUtc();
  freeBusy.timeMax = freeBusy.timeMin.add(Duration(days: 7));

  //Add each calendar to the free busy search array
  freeBusy.items = [];
  for (var i in results.items) {
    FreeBusyRequestItem item = new FreeBusyRequestItem();
    item.id = i.id;
    freeBusy.items.add(item);
  }

  //Fetch results of free busy across all calendars
  var freeBusyResponse = await CalendarApi(httpClient).freebusy.query(freeBusy);
  var collatedTimes = [];
  for (var j in freeBusyResponse.calendars.keys) {
    if (freeBusyResponse.calendars[j].busy.length > 0) {
      for (var k in freeBusyResponse.calendars[j].busy) {
        //Add to the array to pass to the server
        collatedTimes.add(k.toJson());
      }
    }
  }

  //Sort the data across all calendars start to end each day
  collatedTimes.sort((left, right) {
    return left['start'].compareTo(right['start']);
  });

  return collatedTimes;
}
