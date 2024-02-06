// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:project_event/model/data_model/profile/profile_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<ProfileModel>> profileList =
    ValueNotifier<List<ProfileModel>>([]);
ValueNotifier<List<ProfileModel>> profileData =
    ValueNotifier<List<ProfileModel>>([]);
late Database profileDB;

// Function to initialize the database.
Future<void> initializeProfileDB() async {
  profileDB = await openDatabase(
    'profileDB',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'student' table when the database is created.
      await db.execute(
          'CREATE TABLE profile (id INTEGER PRIMARY KEY, imagex TEXT, name TEXT, email TEXT, phone TEXT, address TEXT, password TEXT)');
    },
  );
  // log("profileDB created successfully.");
}

// Function to retrieve student data from the database.
Future<void> refreshRefreshdata() async {
  final result = await profileDB.rawQuery("SELECT * FROM profile");
  profileList.value.clear();
  for (var map in result) {
    final student = ProfileModel.fromMap(map);
    profileList.value.add(student);
  }
  profileList.notifyListeners();
}

Future<void> refreshRefreshid(int id) async {
  final profiledata = await profileDB
      .rawQuery("SELECT * FROM profile WHERE id = ?", [id.toString()]);
  profileData.value.clear();
  for (var map in profiledata) {
    final student = ProfileModel.fromMap(map);
    profileData.value.add(student);
  }
  profileData.notifyListeners();
}

// Function to add a new event to the database.
Future<void> addProfile(ProfileModel value) async {
  try {
    await profileDB.rawInsert(
      'INSERT INTO profile (imagex, name, email, phone, address, password) VALUES(?,?,?,?,?,?)',
      [
        value.imagex,
        value.name,
        value.email,
        value.phone,
        value.address,
        value.password
      ],
    );

    refreshRefreshdata();
  } catch (e) {
    // Handle any errors that occur during data insertion.
    // log('Error inserting data: $e');
  }
}

Future<void> editProfiledata(
    id, imagex, name, email, phone, address, password) async {
  try {
    final dataflow = {
      'imagex': imagex,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
    };

    await profileDB.update('profile', dataflow, where: 'id=?', whereArgs: [id]);
    refreshRefreshdata();
  } catch (e) {
    // log('Error editing data: $e');
  }
}
