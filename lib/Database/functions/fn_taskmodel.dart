// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:project_event/Database/model/Task/task_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<TaskModel>> taskList = ValueNotifier<List<TaskModel>>([]);
late Database taskDB;

// Function to initialize the database.
Future<void> initialize_task_db() async {
  taskDB = await openDatabase(
    'task_db',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'student' table when the database is created.
      await db.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY, taskname TEXT, category TEXT, note TEXT, status BOOLEAN, date TEXT, eventid TEXT, subtask TEXT)');
    },
  );
  print("task_db created successfully.");
}

// Function to retrieve task data from the database.
Future<void> refreshEventtaskdata(int id) async {
  final result = await taskDB.rawQuery(
      "SELECT * FROM task WHERE eventid = ? ORDER BY status DESC",
      [id.toString()]);
  print('All task data: $result');
  taskList.value.clear();
  for (var map in result) {
    final student = TaskModel.fromMap(map);
    taskList.value.add(student);
  }

  // Sort the taskList to place rows with status=false at the beginning
  taskList.value.sort((a, b) {
    if (a.status == 0 && b.status == 1) {
      return -1; // a comes before b
    } else if (a.status == 1 && b.status == 0) {
      return 1; // b comes before a
    } else {
      return 0; // no change in order
    }
  });

  taskList.notifyListeners();
}

// Function to add a new student to the database.
Future<void> addTask(TaskModel value) async {
  try {
    await taskDB.rawInsert(
      'INSERT INTO task(taskname, category, note, status, date, eventid, subtask,id) VALUES(?,?,?,?,?,?,?,?)',
      [
        value.taskname,
        value.category,
        value.note,
        value.status,
        value.date,
        value.eventid,
        value.id
      ],
    );
    log(value.id.toString());
    refreshEventtaskdata(value.eventid);
  } catch (e) {
    //------> Handle any errors that occur during data insertion.
    print('Error inserting data: $e');
  }
}

// Function to delete a student from the database by their ID.
Future<void> deletetask(id, int eventid) async {
  await taskDB.delete('task', where: 'id=?', whereArgs: [id]);
  refreshEventtaskdata(eventid);
}

// Function to edit/update a student's information in the database.
Future<void> editTask(
    id, taskname, category, note, status, date, eventid, subtask) async {
  final dataflow = {
    'taskname': taskname,
    'category': category,
    'note': note,
    'status': status,
    'date': date,
    'eventid': eventid,
    'subtask': subtask
  };
  await taskDB.update('task', dataflow, where: 'id=?', whereArgs: [id]);
  refreshEventtaskdata(eventid);
}

// Function to delete a task's information in the database.
Future<void> clearTaskDatabase() async {
  try {
    await taskDB.delete('task');
    // refreshEventtaskdata(taskDB.value.eventid);
  } catch (e) {
    print('Error while clearing the database: $e');
  }
}
