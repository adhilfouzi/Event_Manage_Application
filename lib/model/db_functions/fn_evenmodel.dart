// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<Eventmodel>> favoriteEventlist = ValueNotifier([]);
ValueNotifier<List<Eventmodel>> eventList = ValueNotifier([]);
ValueNotifier<SearchModel> search = ValueNotifier<SearchModel>(SearchModel());

class SearchModel {
  int pass = 0;
  bool? autofocus = false;
}

late Database eventDB;

// Function to initialize the database.
Future<void> initializeEventDb() async {
  eventDB = await openDatabase(
    'event_db',
    version: 1,
    onCreate: (eventDB, version) async {
      // Create the 'student' table when the database is created.
      await eventDB.execute(
          'CREATE TABLE event (id INTEGER PRIMARY KEY, eventname TEXT, budget TEXT, location TEXT, about TEXT, startingDay TEXT, startingTime TEXT, clientname TEXT, phoneNumber TEXT,emailId TEXT, address TEXT, imagex TEXT, favorite INTEGER, profile INTEGER, FOREIGN KEY (profile) REFERENCES profile(id))');
    },
  );
}

// Function to retrieve student data from the database.
Future<void> refreshEventdata(int profile) async {
  final result = await eventDB
      .rawQuery("SELECT * FROM event WHERE profile = ?", [profile.toString()]);
  eventList.value.clear();

  eventList = sortByDate(eventList, result);
  eventList.notifyListeners();

  ///-----------------------------------------
  ///-----------------------------------------
  ///-----------------------------------------
  final favResult = await eventDB.rawQuery(
      "SELECT * FROM event WHERE favorite = 1 ORDER BY startingDay DESC");
  favoriteEventlist.value.clear();

  favoriteEventlist = sortByDate(favoriteEventlist, favResult);
  favoriteEventlist.notifyListeners();
}

ValueNotifier<List<Eventmodel>> sortByDate(
    ValueNotifier<List<Eventmodel>> valueNotifierList,
    List<Map<String, Object?>> responce) {
  List<Map<String, dynamic>> sortedEvents = [];

  final now = DateTime.now();

  for (var map in responce) {
    final student = Eventmodel.fromMap(map);
    String date = student.startingDay;
    String time = student.startingTime;
    String dateTime = "$date $time";

    DateTime eventDateTime = parseCustomDateTime(dateTime);
    sortedEvents.add({
      'dateTime': eventDateTime,
      'event': student,
      'isFutureEvent': eventDateTime.isAfter(now),
    });
  }

  sortedEvents.sort((a, b) {
    if (a['isFutureEvent'] && !b['isFutureEvent']) {
      return -1; // a should come before b
    } else if (!a['isFutureEvent'] && b['isFutureEvent']) {
      return 1; // b should come before a
    } else {
      // If both are future events or both are past events,
      // sort based on the dateTime
      return b['dateTime'].compareTo(a['dateTime']);
    }
  });

  for (var sortedEvent in sortedEvents) {
    valueNotifierList.value.add(sortedEvent['event']);
  }
  return valueNotifierList;
}

DateTime parseCustomDateTime(String dateTimeString) {
  // Splitting the date-time string into date and time parts
  List<String> parts = dateTimeString.split(' ');

  // Parsing the date part
  List<String> dateParts = parts[0].split('-');
  int day = int.parse(dateParts[0]);
  int month = _getMonthNumber(dateParts[1]);
  int year = int.parse(dateParts[2]);

  // Parsing the time part
  List<String> timeParts =
      parts[1].split(RegExp(r'(?::| )')); // Split by ':' or ' '

  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);
  // Handle AM/PM format
  if (parts[2] == 'PM' && hour != 12) {
    hour += 12;
  } else if (parts[2] == 'AM' && hour == 12) {
    hour = 0;
  }

  log("${DateTime(year, month, day, hour, minute)}");
  // Creating and returning the DateTime object
  return DateTime(year, month, day, hour, minute);
}

int _getMonthNumber(String month) {
  switch (month) {
    case 'January':
      return 1;
    case 'February':
      return 2;
    case 'March':
      return 3;
    case 'April':
      return 4;
    case 'May':
      return 5;
    case 'June':
      return 6;
    case 'July':
      return 7;
    case 'August':
      return 8;
    case 'September':
      return 9;
    case 'October':
      return 10;
    case 'November':
      return 11;
    case 'December':
      return 12;
    default:
      throw FormatException('Invalid month: $month');
  }
}

// Function to add a new event to the database.
Future<void> addEvent(Eventmodel value) async {
  await eventDB.rawInsert(
    'INSERT INTO event (favorite, eventname, budget, location, about, startingDay, startingTime, clientname, phoneNumber, emailId, address, imagex, profile) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)',
    [
      value.favorite,
      value.eventname,
      value.budget,
      value.location,
      value.about,
      value.startingDay,
      value.startingTime,
      value.clientname,
      value.phoneNumber,
      value.emailId,
      value.address,
      value.imagex,
      value.profile,
    ],
  );

  refreshEventdata(value.profile);
}

// Function to delete a student from the database by their ID.
Future<void> deleteEventdata(id, int profileid) async {
  await eventDB.delete('event', where: 'id=?', whereArgs: [id]);
  refreshEventdata(profileid);
}

// Function to edit/update a student's information in the database.
Future<void> editeventdata(
    id,
    eventname,
    budget,
    favorite,
    location,
    about,
    startingDay,
    startingTime,
    clientname,
    phoneNumber,
    emailId,
    address,
    imagex,
    profileid) async {
  final dataflow = {
    'favorite': favorite,
    'eventname': eventname,
    'budget': budget,
    'location': location,
    'about': about,
    'startingDay': startingDay,
    'startingTime': startingTime,
    'clientname': clientname,
    'phoneNumber': phoneNumber,
    'emailId': emailId,
    'address': address,
    'imagex': imagex,
    'profile': profileid, // Change 'profileid' to 'profile'
  };
  await eventDB.update('event', dataflow, where: 'id=?', whereArgs: [id]);
  refreshEventdata(profileid);
}

// Function to delete data from event's database.
Future<void> clearEventDatabase() async {
  await eventDB.delete('event');
}
