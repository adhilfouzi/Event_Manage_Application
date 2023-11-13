import 'dart:developer';

import 'package:flutter/material.dart';
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
          'CREATE TABLE vendortb (id INTEGER PRIMARY KEY, name TEXT, category TEXT, note TEXT,esamount TEXT, clientname TEXT, number TEXT,   email TEXT, address TEXT, eventid INTEGER, FOREIGN KEY (eventid) REFERENCES event(id))');
    },
  );
  print("vendorDB created successfully.");
}

// Function to retrieve vendor data from the database.
Future<void> refreshVendorData(int id) async {
  try {
    final ststr = await vendorDB.rawQuery("SELECT * FROM vendortb");
    log('All vendor data: $ststr');
    log("Refreshing vendor data for event id: $id");
    final result = await vendorDB
        .rawQuery("SELECT * FROM vendortb WHERE eventid = ?", [id.toString()]);
    log('All vendor sorted data: $result');
    vendortlist.value.clear();
    for (var map in result) {
      final student = VendorsModel.fromMap(map);
      vendortlist.value.add(student);
    }
    vendortlist.notifyListeners();
  } catch (e) {
    log('Error Refresh data: $e');
  }
}

// Function to add a new student to the database.
Future<void> addVendor(VendorsModel value) async {
  try {
    log("Adding vendor: $value");
    await vendorDB.rawInsert(
      'INSERT INTO vendortb (name, category, note, esamount, number, email, address, clientname, eventid) VALUES(?,?,?,?,?,?,?,?,?)',
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
      ],
    );

    refreshVendorData(value.eventid);
    log('id:${value.eventid}');
  } catch (e) {
    log('Error inserting data: $e');
  }
}

// Function to delete a vendor from the database by their ID.
Future<void> deleteVendor(id, int eventid) async {
  await vendorDB.delete('vendortb', where: 'id=?', whereArgs: [id]);
  await refreshVendorData(eventid);
}

// Function to edit/update a student's information in the database.
Future<void> editVendor(id, name, category, note, number, esamount, eventid,
    email, address, clientname) async {
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
  };

  await vendorDB.update('vendortb', dataflow, where: 'id=?', whereArgs: [id]);
  await refreshVendorData(eventid);
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
