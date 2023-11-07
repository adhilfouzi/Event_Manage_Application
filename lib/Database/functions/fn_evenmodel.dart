// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<Eventmodel>> eventList = ValueNotifier([]);
late Database eventDB;

// Function to initialize the database.
Future<void> initialize_event_db() async {
  eventDB = await openDatabase(
    'event_db',
    version: 1,
    onCreate: (eventDB, version) async {
      // Create the 'student' table when the database is created.
      await eventDB.execute(
          'CREATE TABLE event (id INTEGER PRIMARY KEY, eventname TEXT, budget TEXT, location TEXT, about TEXT, startingDay TEXT,endingDay TEXT, startingTime TEXT, endingTime TEXT, clientname TEXT, phoneNumber TEXT,emailId TEXT, address TEXT, imagex TEXT)');
    },
  );
  //print("student_db created successfully.");
}

// Function to retrieve student data from the database.
Future<void> refreshEventdata() async {
  final result = await eventDB.rawQuery("SELECT * FROM event");
  log('All event data : $result');
  // print('All event data : ${result}');
  eventList.value.clear();
  for (var map in result) {
    final student = Eventmodel.fromMap(map);
    eventList.value.add(student);
  }
  eventList.notifyListeners();
}

// Function to add a new event to the database.
Future<void> addEvent(Eventmodel value) async {
  try {
    await eventDB.rawInsert(
      'INSERT INTO event(eventname, budget, location, about, startingDay,  startingTime,  clientname, phoneNumber, emailId, address, imagex) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
      [
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
        value.imagex
      ],
    );
    log(value.id.toString());
    refreshEventdata();
  } catch (e) {
    // Handle any errors that occur during data insertion.
    print('Error inserting data: $e');
  }
}

// Function to delete a student from the database by their ID.
Future<void> deleteEventdata(id) async {
  await eventDB.delete('event', where: 'id=?', whereArgs: [id]);
  refreshEventdata();
}

// Function to edit/update a student's information in the database.
Future<void> editeventdata(id, eventname, budget, location, about, startingDay,
    startingTime, clientname, phoneNumber, emailId, address, imagex) async {
  final dataflow = {
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
    'imagex': imagex
  };
  await eventDB.update('event', dataflow, where: 'id=?', whereArgs: [id]);
  refreshEventdata();
}

// Function to delete data from event's database.
Future<void> clearEventDatabase() async {
  try {
    await eventDB.delete('event');
    refreshEventdata();
  } catch (e) {
    print('Error while clearing the database: $e');
  }
}
