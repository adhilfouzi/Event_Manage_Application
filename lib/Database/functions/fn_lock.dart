import 'dart:developer';

import 'package:sqflite/sqflite.dart';

late Database lock;
Future<void> initializelock() async {
  lock = await openDatabase(
    'lock',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'student' table when the database is created.
      await db.execute(
          'CREATE TABLE profile (id INTEGER PRIMARY KEY, login INTEGER, splash INTEGER)');
    },
  );
  log("lock created successfully.");
}

