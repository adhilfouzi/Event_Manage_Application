// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/model/Payment/pay_model.dart';
import 'package:sqflite/sqflite.dart';

enum PaymentType { budget, vendor }

ValueNotifier<PaymentType> paymentTypeNotifier =
    ValueNotifier<PaymentType>(PaymentType.budget);

ValueNotifier<List<PaymentModel>> budgetPaymentList =
    ValueNotifier<List<PaymentModel>>([]);
ValueNotifier<List<PaymentModel>> vendorPaymentlist =
    ValueNotifier<List<PaymentModel>>([]);

late Database paymentDB;

// Function to initialize the database.
Future<void> initializePaymentDatabase() async {
  paymentDB = await openDatabase(
    'paymentDB',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'payment' table when the database is created.
      await db.execute(
          'CREATE TABLE payment (id INTEGER PRIMARY KEY, name TEXT,paytype INTEGER, paytypename TEXT, pyamount TEXT, note TEXT, date TEXT, time TEXT, payid INTEGER, eventid TEXT, FOREIGN KEY (eventid) REFERENCES event(id))');
    },
  );
  print("paymentDB created successfully.");
}

// Function to retrieve payment data from the database.
Future<void> refreshPaymentData(int eventid) async {
  try {
    final resultbd = await paymentDB.rawQuery(
        "SELECT * FROM payment WHERE eventid = ? AND paytype = 0 ORDER BY id DESC",
        [eventid.toString()]);
    print('All budgetPaymentList data: $resultbd');
    budgetPaymentList.value.clear();
    for (var map in resultbd) {
      final student = PaymentModel.fromMap(map);
      budgetPaymentList.value.add(student);
    }
    budgetPaymentList.notifyListeners();

    ///-----------------------------------------
    ///-----------------------------------------

    final resultvn = await paymentDB.rawQuery(
        "SELECT * FROM payment WHERE eventid = ? AND paytype = 1 ORDER BY id DESC",
        [eventid.toString()]);
    print('All vendorPaymentlist data: $resultvn');
    vendorPaymentlist.value.clear();
    for (var map in resultvn) {
      final studentvn = PaymentModel.fromMap(map);
      vendorPaymentlist.value.add(studentvn);
    }
    vendorPaymentlist.notifyListeners();
  } catch (e) {
    log('Error Refresh data: $e');
  }
}

// Function to add a new student to the database.
Future<void> addPayment(PaymentModel value) async {
  try {
    log("Adding payment: $value");
    await paymentDB.rawInsert(
      'INSERT INTO payment (name, paytype, paytypename, pyamount, note, date, time, payid, eventid) VALUES(?,?,?,?,?,?,?,?,?)',
      [
        value.name,
        value.paytype,
        value.paytypename,
        value.pyamount,
        value.note,
        value.date,
        value.time,
        value.payid,
        value.eventid,
      ],
    );

    refreshPaymentData(value.eventid);
    refreshPaymentTypeData(value.payid, value.eventid);
    log('id:${value.eventid}');
  } catch (e) {
    log('Error inserting data: $e');
  }
}

// Function to delete a payment from the database by their ID.
Future<void> deletePayment(id, int eventid, payid) async {
  await paymentDB.delete('payment', where: 'id=?', whereArgs: [id]);
  refreshPaymentData(eventid);
  refreshPaymentTypeData(payid, eventid);
}

// Function to edit/update a student's information in the database.
Future<void> editPayment(id, name, paytype, paytypename, pyamount, note, date,
    time, payid, eventid) async {
  try {
    final dataflow = {
      'name': name,
      'paytype': paytype,
      'paytypename': paytypename,
      'pyamount': pyamount,
      'note': note,
      'date': date,
      'time': time,
      'payid': payid,
      'eventid': eventid,
    };
    await paymentDB.update('payment', dataflow, where: 'id=?', whereArgs: [id]);
    refreshPaymentData(eventid);
    refreshPaymentTypeData(payid, eventid);
  } catch (e) {
    log('Error while editing the database: $e');
  }
}

// Function to delete a task's information in the database.
Future<void> clearPaymentDatabase() async {
  try {
    await paymentDB.delete('payment');
    print(' cleared the task database');
  } catch (e) {
    log('Error while clearing the database: $e');
  }
}
