// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/Database/model/Payment/pay_model.dart';
import 'package:project_event/Database/model/Vendors/vendors_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<VendorsModel>> vendortlist =
    ValueNotifier<List<VendorsModel>>([]);
late Database vendorDB;

// Function to initialize the vendor database.
Future<void> initializeVendorDatabase() async {
  vendorDB = await openDatabase(
    'vendorDB',
    version: 1,
    onCreate: (Database db, version) async {
      await db.execute(
          'CREATE TABLE vendortb (id INTEGER PRIMARY KEY, name TEXT, category TEXT, note TEXT,esamount TEXT, clientname TEXT, number TEXT,   email TEXT, address TEXT, paid INTEGER, pending INTEGER, eventid INTEGER, FOREIGN KEY (eventid) REFERENCES event(id))');
    },
  );
  print("vendorDB created successfully.");
}

// Function to retrieve vendor data from the database.
Future<void> refreshVendorData(int eventid) async {
  try {
    log('refresh started refreshVendorData for eventid: $eventid');

    final vendortb = await vendorDB.rawQuery(
        "SELECT * FROM vendortb WHERE eventid = ? ORDER BY id DESC",
        [eventid.toString()]);

    final payment = await paymentDB.rawQuery(
        "SELECT * FROM payment WHERE eventid = ? AND paytype = 1 ORDER BY id DESC",
        [eventid.toString()]);

    log('Retrieved vendortb data: $vendortb');
    log('Retrieved payment data: $payment');
    vendortlist.value.clear();

    for (var teacher in vendortb) {
      log('vendortb $vendortb');
      int paid = 0;
      final student = VendorsModel.fromMap(teacher);
      for (var parent in payment) {
        log('payment $parent');

        final father = PaymentModel.fromMap(parent);
        if (student.id == father.payid) {
          paid += int.parse(father.pyamount);
        }
      }
      editVendor(
          student.id,
          student.name,
          student.category,
          student.note,
          student.number,
          student.esamount,
          eventid,
          student.email,
          student.address,
          student.clientname,
          paid,
          int.parse(student.esamount) - paid);

      // editBudget(student.id, student.name, student.category, student.note,
      //     student.esamount, paid, int.parse(student.esamount) - paid, eventid);
    }

    for (var map in vendortb) {
      final student = VendorsModel.fromMap(map);
      vendortlist.value.add(student);
    }
    vendortlist.notifyListeners();
  } catch (e) {
    if (e is DatabaseException) {
      // Handle SQLite-specific errors
      print('SQLite Error: $e');
    } else {
      // Handle other exceptions
      print('Error inserting data: $e');
    }
  }
}

// Function to add a new student to the database.
Future<void> addVendor(VendorsModel value) async {
  try {
    log("Adding vendor: $value");
    final vendortb = await vendorDB.rawInsert(
      'INSERT INTO vendortb (name, category, note, esamount, number, email, address, clientname, eventid, paid, pending) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
      [
        value.name,
        value.category,
        value.note,
        value.esamount,
        value.number,
        value.email,
        value.address,
        value.clientname,
        value.eventid,
        value.paid,
        value.pending
      ],
    );
    log('eventid:${value.eventid}');

    //refreshVendorData(value.eventid);
    log('added data:${vendortb}');
    log('eventid:${value.name}');

    log("Adding completed succesfully");
  } catch (e) {
    if (e is DatabaseException) {
      // Handle SQLite-specific errors
      log('SQLite Error: $e');
    } else {
      // Handle other exceptions
      log('Error inserting data: $e');
    }
  }
}

// Function to delete a vendor from the database by their ID.
Future<void> deleteVendor(id, int eventid) async {
  await vendorDB.delete('vendortb', where: 'id=?', whereArgs: [id]);
  await refreshVendorData(eventid);
}

// Function to edit/update a student's information in the database.
Future<void> editVendor(id, name, category, note, number, esamount, eventid,
    email, address, clientname, paid, pending) async {
  final dataflow = {
    'name': name,
    'category': category,
    'esamount': esamount,
    'note': note,
    'eventid': eventid,
    'number': number,
    'email': email,
    'address': address,
    'clientname': clientname,
    'paid': paid,
    'pending': pending,
  };

  await vendorDB.update('vendortb', dataflow, where: 'id=?', whereArgs: [id]);
  //await refreshVendorData(eventid);
}

// Function to delete data from event's database.
Future<void> clearVendorDatabase() async {
  try {
    await vendorDB.delete('vendortb');
    print(' cleared the vendortb database');
  } catch (e) {
    print('Error while clearing the database: $e');
  }
}
