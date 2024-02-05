// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:project_event/database/functions/fn_budgetmodel.dart';
import 'package:project_event/database/functions/fn_incomemodel.dart';
import 'package:project_event/database/functions/fn_paymodel.dart';
import 'package:project_event/database/functions/fn_vendormodel.dart';
import 'package:project_event/database/model/budget_model/budget_model.dart';
import 'package:project_event/database/model/payment/pay_model.dart';
import 'package:project_event/database/model/vendors/vendors_model.dart';

ValueNotifier<List<PaymentModel>> budgetPaymentDetails =
    ValueNotifier<List<PaymentModel>>([]);
ValueNotifier<List<PaymentModel>> vendorPaymentDetails =
    ValueNotifier<List<PaymentModel>>([]);

ValueNotifier<List<int>> vendorpayid = ValueNotifier<List<int>>([]);
ValueNotifier<List<int>> budgetpayid = ValueNotifier<List<int>>([]);

// Function to retrieve payment for view selected data from the database.
Future<void> refreshPaymentTypeData(int payid, int eventid) async {
  final resulter = await paymentDB.rawQuery(
      "SELECT * FROM payment WHERE eventid = ? AND paytype = 0 AND payid = ?",
      [eventid.toString(), payid.toString()]);
  budgetPaymentDetails.value.clear();
  for (var map in resulter) {
    final student = PaymentModel.fromMap(map);
    budgetPaymentDetails.value.add(student);
  }
  budgetPaymentDetails.notifyListeners();

  ///-----------------------------------------

  final resultven = await paymentDB.rawQuery(
      "SELECT * FROM payment WHERE eventid = ? AND paytype = 1 AND payid = ?",
      [eventid.toString(), payid.toString()]);
  vendorPaymentDetails.value.clear();
  for (var map in resultven) {
    final studentven = PaymentModel.fromMap(map);
    vendorPaymentDetails.value.add(studentven);
  }
  vendorPaymentDetails.notifyListeners();
}

Future<void> refreshPaymentpayid(int eventid) async {
  final resultset = await budgetDB
      .rawQuery("SELECT * FROM budget WHERE eventid = ?", [eventid.toString()]);

  budgetpayid.value.clear();

  for (var map in resultset) {
    final student = BudgetModel.fromMap(map);
    budgetpayid.value.add(student.id!); // Store only the payid
  }

  ///-----------------------------------------
  ///-----------------------------------------
  final resultsetr = await vendorDB.rawQuery(
      "SELECT * FROM vendortb WHERE eventid = ?", [eventid.toString()]);

  // Clearing vendorpayid.value only once, not twice
  vendorpayid.value.clear();

  for (var map in resultsetr) {
    final student = VendorsModel.fromMap(map);
    vendorpayid.value.add(student.id!); // Store only the payid
  }

  vendorpayid.notifyListeners();
}

ValueNotifier<Balence> balance =
    ValueNotifier<Balence>(Balence(paid: 0, total: 0, pending: 0));
Future<void> refreshbalancedata(
    int payid, int eventid, int bol, String amound) async {
  final resulter = await paymentDB.rawQuery(
      "SELECT * FROM payment WHERE eventid = ? AND paytype = ? AND payid = ?",
      [eventid.toString(), bol, payid.toString()]);
  // print('All budgetPaymentdetiled data: $resulter');
  int paid = 0;
  for (var map in resulter) {
    final student = PaymentModel.fromMap(map);

    // Filter out non-numeric characters and parse the amount
    int amound = int.parse(student.pyamount.replaceAll(RegExp(r'[^0-9]'), ''));

    paid += amound;
  }

  // Filter out non-numeric characters and parse the total amount
  int totalAmound = int.parse(amound.replaceAll(RegExp(r'[^0-9]'), ''));

  Balence b = Balence(
    paid: paid,
    total: totalAmound,
    pending: totalAmound - paid,
  );
  balance.value = b;
  balance.notifyListeners();
}

class Balence {
  int paid;
  int total;
  int pending;
  Balence({required this.paid, required this.total, required this.pending});
}

ValueNotifier<Balence> mainbalance =
    ValueNotifier<Balence>(Balence(paid: 0, total: 0, pending: 0));

Future<void> refreshmainbalancedata(int eventid) async {
  final resultpayment = await paymentDB.rawQuery(
      "SELECT * FROM payment WHERE eventid = ?", [eventid.toString()]);
  int payment = 0;
  for (var map in resultpayment) {
    final student = PaymentModel.fromMap(map);

    // Filter out non-numeric characters and parse the amount
    int amound = int.parse(student.pyamount.replaceAll(RegExp(r'[^0-9]'), ''));

    payment += amound;
  }
///////////////////////////////////////////////////////////
  final resultincome = await incomeDB
      .rawQuery("SELECT * FROM income WHERE eventid = ?", [eventid.toString()]);

  int income = 0;
  for (var dora in resultincome) {
    final student = IncomeModel.fromMap(dora);

    // Filter out non-numeric characters and parse the amount
    int amound = int.parse(student.pyamount.replaceAll(RegExp(r'[^0-9]'), ''));

    income += amound;
  }
///////////////////////////////////////////////////////////
  Balence b = Balence(
    paid: payment,
    total: income - payment,
    pending: income,
  );
  mainbalance.value = b;
  mainbalance.notifyListeners();
}

Future<void> deletePayBudget(int eventid, payid) async {
  final resulter = await paymentDB.rawQuery(
      "SELECT * FROM payment WHERE eventid = ? AND paytype = 0 AND payid = ?",
      [eventid.toString(), payid.toString()]);
  for (var del in resulter) {
    await paymentDB.delete('payment', where: 'id=?', whereArgs: [del['id']]);
  }
  refreshPaymentData(eventid);
  refreshPaymentTypeData(payid, eventid);
}

Future<void> deletePayVendor(int eventid, payid) async {
  final resulter = await paymentDB.rawQuery(
      "SELECT * FROM payment WHERE eventid = ? AND paytype = 1 AND payid = ?",
      [eventid.toString(), payid.toString()]);
  for (var del in resulter) {
    await paymentDB.delete('payment', where: 'id=?', whereArgs: [del['id']]);
  }
  refreshPaymentData(eventid);
  refreshPaymentTypeData(payid, eventid);
}
