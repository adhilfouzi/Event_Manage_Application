// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/db_functions/fn_paymodel.dart';
import 'package:project_event/model/data_model/payment/pay_model.dart';
import 'package:project_event/model/data_model/vendors/vendors_model.dart';

import 'package:sqflite/sqflite.dart';

ValueNotifier<List<VendorsModel>> vendortlist =
    ValueNotifier<List<VendorsModel>>([]);
ValueNotifier<List<VendorsModel>> vendorDonelist =
    ValueNotifier<List<VendorsModel>>([]);
ValueNotifier<List<VendorsModel>> vendorPendinglist =
    ValueNotifier<List<VendorsModel>>([]);
late Database vendorDB;

// Function to initialize the vendor database.
Future<void> initializeVendorDatabase() async {
  vendorDB = await openDatabase(
    'vendorDB',
    version: 1,
    onCreate: (Database db, version) async {
      await db.execute(
          'CREATE TABLE vendortb (id INTEGER PRIMARY KEY, name TEXT, category TEXT, note TEXT,esamount TEXT, clientname TEXT, number TEXT, email TEXT, address TEXT, paid INTEGER, pending INTEGER, status INTEGER, eventid INTEGER, FOREIGN KEY (eventid) REFERENCES event(id))');
    },
  );
  // print("vendorDB created successfully.");
}

// Function to retrieve vendor data from the database.
Future<void> refreshVendorData(int eventid) async {
  final vendortb = await vendorDB.rawQuery(
      "SELECT * FROM vendortb WHERE eventid = ? ORDER BY status ASC",
      [eventid.toString()]);

  final payment = await paymentDB.rawQuery(
      "SELECT * FROM payment WHERE eventid = ? AND paytype = 1 ORDER BY id DESC",
      [eventid.toString()]);
  vendortlist.value.clear();

  for (var teacher in vendortb) {
    int paid = 0;
    final student = VendorsModel.fromMap(teacher);
    for (var parent in payment) {
      final father = PaymentModel.fromMap(parent);
      if (student.id == father.payid) {
        paid += int.parse(father.pyamount.replaceAll(RegExp(r'[^0-9]'), ''));
      }
    }
    int pending =
        int.parse(student.esamount.replaceAll(RegExp(r'[^0-9]'), '')) - paid;
    int status =
        paid >= int.parse(student.esamount.replaceAll(RegExp(r'[^0-9]'), ''))
            ? 1
            : 0;
    await editVendor(
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
      pending,
      status,
    );
  }

  for (var map in vendortb) {
    final student = VendorsModel.fromMap(map);
    vendortlist.value.add(student);
  }
  vendortlist.notifyListeners();

  ///-----------------------------------------
  ///-----------------------------------------
  ///-------------------------------------
  final rpDoneVendor = await vendorDB.rawQuery(
      "SELECT * FROM vendortb WHERE eventid = ? AND status = 1",
      [eventid.toString()]);

  // print('rpDonevendortb : $rpDoneVendor');
  vendorDonelist.value.clear();
  for (var map in rpDoneVendor) {
    final student = VendorsModel.fromMap(map);
    vendorDonelist.value.add(student);
  }
  vendorDonelist.notifyListeners();

  ///-----------------------------------------
  ///-----------------------------------------
  ///-------------------------------------
  final rpPendingvendor = await vendorDB.rawQuery(
      "SELECT * FROM vendortb WHERE eventid = ? AND status = 0",
      [eventid.toString()]);
  // print('rpDonevendortb : $rpPendingvendor');
  vendorPendinglist.value.clear();
  for (var map in rpPendingvendor) {
    final student = VendorsModel.fromMap(map);
    vendorPendinglist.value.add(student);
  }
  vendorPendinglist.notifyListeners();
  await refreshmainbalancedata(eventid);
}

// Function to add a new student to the database.
Future<void> addVendor(VendorsModel value) async {
  try {
    // log("Adding vendor: $value");
    await vendorDB.rawInsert(
      'INSERT INTO vendortb (name, category, note, esamount, number, email, address, clientname, eventid, paid, pending, status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
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
        value.pending,
        value.status
      ],
    );
  } catch (e) {
    if (e is DatabaseException) {
      // Handle SQLite-specific errors
      // log('SQLite Error: $e');
    } else {
      // Handle other exceptions
      // log('Error inserting data: $e');
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
    email, address, clientname, paid, pending, status) async {
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
    'status': status,
  };

  await vendorDB.update('vendortb', dataflow, where: 'id=?', whereArgs: [id]);
  //await refreshVendorData(eventid);
}

// Function to delete data from event's database.
Future<void> clearVendorDatabase() async {
  try {
    await vendorDB.delete('vendortb');
    // print(' cleared the vendortb database');
  } catch (e) {
    // print('Error while clearing the database: $e');
  }
}
