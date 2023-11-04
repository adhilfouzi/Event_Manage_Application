// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:project_event/Database/model/Task/task_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<Subtaskmodel>> subtasklist =
    ValueNotifier<List<Subtaskmodel>>([]);
late Database subtaskDB;

// Function to initialize the database.
Future<void> initialize_Subtask_Database() async {
  subtaskDB = await openDatabase(
    'subtask_db',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'student' table when the database is created.
      await db.execute(
          'CREATE TABLE subtask (id TEXT PRIMARY KEY, subtaskname TEXT, subtasknote TEXT, subtaskstatus BOOLEAN)');
    },
  );
  print("Database created successfully.");
}

// Function to retrieve subtask data from the database.
Future<void> refreshsubtaskdata() async {
  try {
    final result = await subtaskDB.rawQuery("SELECT * FROM subtask");
    print('All subtask data : ${result}');
    subtasklist.value.clear();
    for (var map in result) {
      final student = Subtaskmodel.fromMap(map);
      subtasklist.value.add(student);
    }
    subtasklist.notifyListeners();
  } catch (e) {
    print('Error refreshing data: $e');
  }
}

// Function to add a new student to the database.
Future<void> addSubTask(Subtaskmodel value) async {
  try {
    await subtaskDB.rawInsert(
      'INSERT INTO subtask(subtaskname, subtasknote, subtaskstatus) VALUES(?,?,?)',
      [value.subtaskname, value.subtasknote, value.subtaskstatus],
    );
    refreshsubtaskdata();
  } catch (e) {
    //------> Handle any errors that occur during data insertion.
    print('Error inserting data: $e');
  }
}

// Function to delete a student from the database by their ID.
Future<void> deleteSubtask(id) async {
  await subtaskDB.delete('subtask', where: 'id=?', whereArgs: [id]);
  refreshsubtaskdata();
}

// Function to edit/update a student's information in the database.
Future<void> editStudent(id, subtaskname, subtasknote, subtaskstatus) async {
  final dataflow = {
    'subtaskname': subtaskname,
    'subtasknote': subtasknote,
    'subtaskstatus': subtaskstatus,
  };
  await subtaskDB.update('subtask', dataflow, where: 'id=?', whereArgs: [id]);
  refreshsubtaskdata();
}

// Function to delete data from event's database.
Future<void> clearEventDatabase() async {
  try {
    await subtaskDB.delete('subtask');
    refreshsubtaskdata();
  } catch (e) {
    print('Error while clearing the database: $e');
  }
}
