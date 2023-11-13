// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<BudgetModel>> budgetlist =
    ValueNotifier<List<BudgetModel>>([]);
late Database budgetDB;

// Function to initialize the database.
Future<void> initializeBudgetDatabase() async {
  budgetDB = await openDatabase(
    'budgetDB',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'student' table when the database is created.
      await db.execute(
          'CREATE TABLE budget (id INTEGER PRIMARY KEY, name TEXT, category TEXT, note TEXT, esamount TEXT, eventid TEXT, FOREIGN KEY (eventid) REFERENCES event(id))');
    },
  );
  print("budgetDB created successfully.");
}

// Function to retrieve task data from the database.
Future<void> refreshBudgetData(int id) async {
  final result = await budgetDB
      .rawQuery("SELECT * FROM budget WHERE eventid = ?", [id.toString()]);
  print('All budget data: $result');
  budgetlist.value.clear();
  for (var map in result) {
    final student = BudgetModel.fromMap(map);
    budgetlist.value.add(student);
  }

  budgetlist.notifyListeners();
}

// Function to add a new student to the database.
Future<void> addBudget(BudgetModel value) async {
  try {
    await budgetDB.rawInsert(
      'INSERT INTO budget(name, category, note, esamount, eventid) VALUES(?,?,?,?,?)',
      [
        value.name,
        value.category,
        value.note,
        value.esamount,
        value.eventid,
      ],
    );
    refreshBudgetData(value.eventid);
  } catch (e) {
    //------> Handle any errors that occur during data insertion.
    print('Error inserting data: $e');
  }
}

// Function to delete a student from the database by their ID.
Future<void> deleteBudget(id, int eventid) async {
  await budgetDB.delete('budget', where: 'id=?', whereArgs: [id]);
  refreshBudgetData(eventid);
}

// Function to edit/update a student's information in the database.
Future<void> editBudget(id, name, category, note, esamount, eventid) async {
  final dataflow = {
    'name': name,
    'category': category,
    'esamount': esamount,
    'note': note,
    'eventid': eventid,
  };
  await budgetDB.update('budget', dataflow, where: 'id=?', whereArgs: [id]);
  refreshBudgetData(eventid);
}

// Function to delete data from event's database.
Future<void> clearBudgetDatabase() async {
  try {
    await budgetDB.delete('budget');
    print(' cleared the budget database');
  } catch (e) {
    print('Error while clearing the database: $e');
  }
}
