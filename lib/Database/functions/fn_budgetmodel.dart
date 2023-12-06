// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/Database/model/Payment/pay_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<BudgetModel>> budgetlist =
    ValueNotifier<List<BudgetModel>>([]);
ValueNotifier<List<BudgetModel>> budgetDonelist =
    ValueNotifier<List<BudgetModel>>([]);
ValueNotifier<List<BudgetModel>> budgetPendinglist =
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
          'CREATE TABLE budget (id INTEGER PRIMARY KEY, name TEXT, category TEXT, note TEXT, esamount TEXT, paid INTEGER, pending INTEGER,status INTEGER, eventid TEXT, FOREIGN KEY (eventid) REFERENCES event(id))');
    },
  );
}

// Function to retrieve task data from the database.
Future<void> refreshBudgetData(int eventid) async {
  final budget = await budgetDB.rawQuery(
      "SELECT * FROM budget WHERE eventid = ?  ORDER BY status ASC",
      [eventid.toString()]);
  budgetlist.value.clear();
//////////////////////////////////////////////////////////////
  final payment = await paymentDB.rawQuery(
      "SELECT * FROM payment WHERE eventid = ? AND paytype = 0 ORDER BY id DESC",
      [eventid.toString()]);
////////////////////////////////////////////////////////.
  for (var teacher in budget) {
    int paid = 0;
    final student = BudgetModel.fromMap(teacher);
    for (var parent in payment) {
      final father = PaymentModel.fromMap(parent);
      if (student.id == father.payid) {
        paid += int.parse(father.pyamount.replaceAll(RegExp(r'[^0-9]'), ''));
      }
    }

    editBudget(
        student.id,
        student.name,
        student.category,
        student.note,
        student.esamount,
        paid,
        int.parse(student.esamount.replaceAll(RegExp(r'[^0-9]'), '')) - paid,
        eventid,
        paid >= int.parse(student.esamount.replaceAll(RegExp(r'[^0-9]'), ''))
            ? 1
            : 0);
  }
  await refreshmainbalancedata(eventid);

  for (var map in budget) {
    final student = BudgetModel.fromMap(map);
    budgetlist.value.add(student);
  }

  budgetlist.notifyListeners();

  ///-----------------------------------------
  ///-----------------------------------------
  ///-------------------------------------
  final rpDonebudget = await budgetDB.rawQuery(
      "SELECT * FROM budget WHERE eventid = ? AND status = 1",
      [eventid.toString()]);

  budgetDonelist.value.clear();
  for (var map in rpDonebudget) {
    final student = BudgetModel.fromMap(map);
    budgetDonelist.value.add(student);
  }
  budgetDonelist.notifyListeners();

  ///-----------------------------------------
  ///-----------------------------------------
  ///-----------------------------------------
  final rpPendingbudget = await budgetDB.rawQuery(
      "SELECT * FROM budget WHERE eventid = ? AND status = 0",
      [eventid.toString()]);
  budgetPendinglist.value.clear();
  for (var map in rpPendingbudget) {
    final student = BudgetModel.fromMap(map);
    budgetPendinglist.value.add(student);
  }
  budgetPendinglist.notifyListeners();
}

// Function to add a new student to the database.
Future<void> addBudget(BudgetModel value) async {
  await budgetDB.rawInsert(
    'INSERT INTO budget(name, category, note, esamount, eventid, paid, pending, status) VALUES(?,?,?,?,?,?,?,?)',
    [
      value.name,
      value.category,
      value.note,
      value.esamount,
      value.eventid,
      value.paid,
      value.pending,
      value.status
    ],
  );
}

// Function to delete a student from the database by their ID.
Future<void> deleteBudget(id, int eventid) async {
  await budgetDB.delete('budget', where: 'id=?', whereArgs: [id]);
}

// Function to edit/update a student's information in the database.
Future<void> editBudget(
    id, name, category, note, esamount, paid, pending, eventid, status) async {
  final dataflow = {
    'name': name,
    'category': category,
    'esamount': esamount,
    'note': note,
    'eventid': eventid,
    'paid': paid,
    'pending': pending,
    'status': status
  };
  await budgetDB.update('budget', dataflow, where: 'id=?', whereArgs: [id]);
}

// Function to delete data from event's database.
Future<void> clearBudgetDatabase() async {
  await budgetDB.delete('budget');
}
