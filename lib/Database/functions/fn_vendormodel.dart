import 'package:flutter/material.dart';
import 'package:project_event/Database/model/Vendors/vendors.dart';
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
          'CREATE TABLE vendor (id INTEGER PRIMARY KEY, name TEXT, category TEXT, note TEXT, number TEXT, esamount TEXT, eventid INTEGER, email TEXT, address TEXT, clientname TEXT)');
    },
  );
  print("vendorDB created successfully.");
}

// Function to retrieve vendor data from the database.
Future<void> refreshVendorData(int id) async {
  final result = await vendorDB
      .rawQuery("SELECT * FROM vendor WHERE eventid = ?", [id.toString()]);
  print('All vendor data: $result');
  vendortlist.value.clear();
  for (var map in result) {
    final student = VendorsModel.fromMap(map);
    vendortlist.value.add(student);
  }

  vendortlist.notifyListeners();
}

// Function to add a new student to the database.
Future<void> addVendor(VendorsModel value) async {
  try {
    await vendorDB.rawInsert(
      'INSERT INTO vendor( name , category, note, number, esamount, eventid, email, address, clientname) VALUES(?,?,?,?,?,?,?,?,?)',
      [
        value.name,
        value.category,
        value.note,
        value.esamount,
        value.number,
        value.email,
        value.address,
        value.eventid,
        value.clientname,
      ],
    );
    refreshVendorData(value.eventid);
  } catch (e) {
    //------> Handle any errors that occur during data insertion.
    print('Error inserting data: $e');
  }
}

// Function to delete a vendor from the database by their ID.
Future<void> deleteVendor(id, int eventid) async {
  await vendorDB.delete('vendor', where: 'id=?', whereArgs: [id]);
  refreshVendorData(eventid);
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

  await vendorDB.update('vendor', dataflow, where: 'id=?', whereArgs: [id]);
  refreshVendorData(eventid);
}

// Function to delete data from event's database.
Future<void> clearVendorDatabase() async {
  try {
    await vendorDB.delete('vendor');
  } catch (e) {
    print('Error while clearing the database: $e');
  }
}
