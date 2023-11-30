// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
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
  //print("student_db created successfully.");
}

// Function to retrieve student data from the database.
Future<void> refreshEventdata(int profile) async {
  // final result1 =
  //     await eventDB.rawQuery("SELECT * FROM event ORDER BY id DESC");
  // log('All result1 data : ${result1}');
  final result = await eventDB.rawQuery(
      "SELECT * FROM event WHERE profile = ? ORDER BY startingDay DESC",
      [profile.toString()]);
  print('All event data : ${result}');
  eventList.value.clear();
  for (var map in result) {
    final student = Eventmodel.fromMap(map);
    eventList.value.add(student);
  }
  eventList.notifyListeners();

  ///-----------------------------------------
  ///-----------------------------------------
  ///-----------------------------------------
  final favResult = await eventDB.rawQuery(
      "SELECT * FROM event WHERE favorite = 1 ORDER BY startingDay DESC");
  print('Favorite event data : ${favResult}');
  favoriteEventlist.value.clear();
  for (var map in favResult) {
    final student = Eventmodel.fromMap(map);
    favoriteEventlist.value.add(student);
  }
  favoriteEventlist.notifyListeners();
}

// Function to add a new event to the database.
Future<void> addEvent(Eventmodel value) async {
  try {
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
  } catch (e) {
    // Handle any errors that occur during data insertion.
    print('Error inserting data: $e');
  }
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
  try {
    await eventDB.delete('event');
    print(' cleared the event database');
  } catch (e) {
    print('Error while clearing the database: $e');
  }
}
