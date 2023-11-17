import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/model/Payment/pay_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<IncomeModel>> incomePaymentList =
    ValueNotifier<List<IncomeModel>>([]);

late Database incomeDB;

Future<void> initializeIncomeDatabase() async {
  incomeDB = await openDatabase(
    'incomeDB',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'incomeDB' table when the database is created.
      await db.execute(
          'CREATE TABLE income (id INTEGER PRIMARY KEY, name TEXT, pyamount TEXT, note TEXT, date TEXT, time TEXT, eventid TEXT, FOREIGN KEY (eventid) REFERENCES event(id))');
    },
  );
  print("incomeDB created successfully.");
}

Future<void> refreshincomedata(int eventid) async {
  final result = await incomeDB
      .rawQuery("SELECT * FROM income WHERE eventid = ?", [eventid.toString()]);
  print('All income data: $result');
  incomePaymentList.value.clear();
  for (var map in result) {
    final student = IncomeModel.fromMap(map);
    incomePaymentList.value.add(student);
  }

  incomePaymentList.notifyListeners();
}

Future<void> addincome(IncomeModel value) async {
  try {
    await incomeDB.rawInsert(
      'INSERT INTO income(name, pyamount, note, date, time, eventid) VALUES(?,?,?,?,?,?)',
      [
        value.name,
        value.pyamount,
        value.note,
        value.date,
        value.time,
        value.eventid,
      ],
    );
    log(value.id.toString());
    refreshincomedata(value.eventid);
  } catch (e) {
    //------> Handle any errors that occur during data insertion.
    print('Error inserting data: $e');
  }
}

Future<void> deleteincome(id, int eventid) async {
  await incomeDB.delete('income', where: 'id=?', whereArgs: [id]);
  refreshincomedata(eventid);
}

Future<void> editincome(id, name, pyamount, note, date, time, eventid) async {
  try {
    final dataflow = {
      'name': name,
      'pyamount': pyamount,
      'note': note,
      'date': date,
      'time': time,
      'eventid': eventid,
    };
    await incomeDB.update('income', dataflow, where: 'id=?', whereArgs: [id]);
    refreshincomedata(eventid);
  } catch (e) {
    log('Error while editing the database: $e');
  }
}

Future<void> clearincomeDatabase() async {
  try {
    await incomeDB.delete('income');
    print(' cleared the incomeDB database');
  } catch (e) {
    log('Error while clearing the database: $e');
  }
}
