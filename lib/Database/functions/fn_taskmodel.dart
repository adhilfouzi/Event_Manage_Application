// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/model/Task/task_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<TaskModel>> taskList = ValueNotifier<List<TaskModel>>([]);
ValueNotifier<List<TaskModel>> doneRpTaskList = ValueNotifier([]);
ValueNotifier<List<TaskModel>> pendingRpTaskList = ValueNotifier([]);

late Database taskDB;

// Function to initialize the database.
Future<void> initializeTaskDb() async {
  taskDB = await openDatabase(
    'task_db',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'student' table when the database is created.
      await db.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY, taskname TEXT, category TEXT, note TEXT, status INTEGER, date TEXT, eventid TEXT, FOREIGN KEY (eventid) REFERENCES event(id))');
    },
  );
  log("task_db created successfully.");
}

// Function to retrieve task data from the database.
Future<void> refreshEventtaskdata(int id) async {
  final result = await taskDB.rawQuery(
      "SELECT * FROM task WHERE eventid = ? ORDER BY status ASC",
      [id.toString()]);
  log('All task data: $result');
  taskList.value.clear();
  for (var map in result) {
    final student = TaskModel.fromMap(map);
    taskList.value.add(student);
  }

  taskList.notifyListeners();

  ///-----------------------------------------
  ///-----------------------------------------
  ///-------------------------------------
  final rpDoneTask = await taskDB.rawQuery(
      "SELECT * FROM task WHERE eventid = ? AND status = 1", [id.toString()]);

  log('rpDonetask : $rpDoneTask');
  doneRpTaskList.value.clear();
  for (var map in rpDoneTask) {
    final student = TaskModel.fromMap(map);
    doneRpTaskList.value.add(student);
  }
  doneRpTaskList.notifyListeners();

  ///-----------------------------------------
  ///-----------------------------------------
  ///-------------------------------------
  final rpPendingtask = await taskDB.rawQuery(
      "SELECT * FROM task WHERE eventid = ? AND status = 0", [id.toString()]);
  log('rpDonetask : $rpPendingtask');
  pendingRpTaskList.value.clear();
  for (var map in rpPendingtask) {
    final student = TaskModel.fromMap(map);
    pendingRpTaskList.value.add(student);
  }
  pendingRpTaskList.notifyListeners();
  await refreshmainbalancedata(id);
}

// Function to add a new student to the database.
Future<void> addTask(TaskModel value) async {
  try {
    await taskDB.rawInsert(
      'INSERT INTO task(taskname, category, note, status, date, eventid, id) VALUES(?,?,?,?,?,?,?)',
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
    refreshEventtaskdata(value.eventid);
  } catch (e) {
    //------> Handle any errors that occur during data insertion.
    log('Error inserting data: $e');
  }
}

// Function to delete a student from the database by their ID.
Future<void> deletetask(id, int eventid) async {
  await taskDB.delete('task', where: 'id=?', whereArgs: [id]);
  refreshEventtaskdata(eventid);
}

// Function to edit/update a student's information in the database.
Future<void> editTask(
    id, taskname, category, note, status, date, eventid) async {
  final dataflow = {
    'taskname': taskname,
    'category': category,
    'note': note,
    'status': status,
    'date': date,
    'eventid': eventid,
  };
  await taskDB.update('task', dataflow, where: 'id=?', whereArgs: [id]);
  refreshEventtaskdata(eventid);
}

// Function to delete a task's information in the database.
Future<void> clearTaskDatabase() async {
  try {
    await taskDB.delete('task');
    log(' cleared the task database');
  } catch (e) {
    log('Error while clearing the database: $e');
  }
}
