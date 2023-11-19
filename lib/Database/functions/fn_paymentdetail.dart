// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_incomemodel.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/Database/model/Payment/pay_model.dart';
import 'package:project_event/Database/model/Vendors/vendors_model.dart';

ValueNotifier<List<PaymentModel>> budgetPaymentDetails =
    ValueNotifier<List<PaymentModel>>([]);
ValueNotifier<List<PaymentModel>> vendorPaymentDetails =
    ValueNotifier<List<PaymentModel>>([]);

ValueNotifier<List<int>> vendorpayid = ValueNotifier<List<int>>([]);
ValueNotifier<List<int>> budgetpayid = ValueNotifier<List<int>>([]);

// Function to retrieve payment for view selected data from the database.
Future<void> refreshPaymentTypeData(int payid, int eventid) async {
  try {
    try {
      final resulter = await paymentDB.rawQuery(
          "SELECT * FROM payment WHERE eventid = ? AND paytype = 0 AND payid = ?",
          [eventid.toString(), payid.toString()]);
      print('All budgetPaymentdetiled data: $resulter');
      budgetPaymentDetails.value.clear();
      for (var map in resulter) {
        final student = PaymentModel.fromMap(map);
        budgetPaymentDetails.value.add(student);
      }
      budgetPaymentDetails.notifyListeners();
    } catch (e, stackTrace) {
      log('Error in refreshPaymentTypeData: $e\n$stackTrace');
    }

    ///-----------------------------------------

    final resultven = await paymentDB.rawQuery(
        "SELECT * FROM payment WHERE eventid = ? AND paytype = 1 AND payid = ?",
        [eventid.toString(), payid.toString()]);
    print('All vendorPaymentlist data: $resultven');
    vendorPaymentDetails.value.clear();
    for (var map in resultven) {
      final studentven = PaymentModel.fromMap(map);
      vendorPaymentDetails.value.add(studentven);
    }
    vendorPaymentDetails.notifyListeners();
  } catch (e) {
    log('Error Refresh Details view data: $e');
  }
}

Future<void> refreshPaymentpayid(int eventid) async {
  try {
    final resultset = await budgetDB.rawQuery(
        "SELECT * FROM budget WHERE eventid = ?", [eventid.toString()]);

    budgetpayid.value.clear();

    for (var map in resultset) {
      final student = BudgetModel.fromMap(map);
      budgetpayid.value.add(student.id!); // Store only the payid
    }
    log('All budget data id: ${budgetpayid.value}');

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

    log('All vendortb data id: ${vendorpayid.value}');
    vendorpayid.notifyListeners();
  } catch (e) {
    log('Error Refresh Details id data: $e');
  }
}

ValueNotifier<Balence> balance =
    ValueNotifier<Balence>(Balence(paid: 0, total: 0, pending: 0));

Future<void> refreshbalancedata(
    int payid, int eventid, int bol, String amound) async {
  try {
    final resulter = await paymentDB.rawQuery(
        "SELECT * FROM payment WHERE eventid = ? AND paytype = ? AND payid = ?",
        [eventid.toString(), bol, payid.toString()]);
    print('All budgetPaymentdetiled data: $resulter');
    int paid = 0;
    for (var map in resulter) {
      final student = PaymentModel.fromMap(map);
      int amound = int.parse(student.pyamount);
      paid += amound;
    }

    // int total = int.parse(amound);
    // int pending = total - paid;
    Balence b = Balence(
        paid: paid,
        total: int.parse(amound),
        pending: int.parse(amound) - paid);
    balance.value = b;
    balance.notifyListeners();
  } catch (e, stackTrace) {
    log('Error in refreshPaymentTypeData: $e\n$stackTrace');
  }
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
  try {
    log('refresh start');
    log('eventid :${eventid}');

    final resultpayment = await paymentDB.rawQuery(
        "SELECT * FROM payment WHERE eventid = ?", [eventid.toString()]);
    print('All resultpayment data: $resultpayment');
    int payment = 0;
    for (var map in resultpayment) {
      final student = PaymentModel.fromMap(map);
      int amound = int.parse(student.pyamount);
      payment += amound;
    }
    log('payment :${payment}');
///////////////////////////////////////////////////////////
    final resultincome = await incomeDB.rawQuery(
        "SELECT * FROM income WHERE eventid = ?", [eventid.toString()]);
    print('All resultincome data: $resultincome');

    int income = 0;
    for (var dora in resultincome) {
      final student = IncomeModel.fromMap(dora);
      int amound = int.parse(student.pyamount);
      income += amound;
    }
    log('payment :${payment}');
    log('income :${income}');

    Balence b =
        Balence(paid: payment, total: income - payment, pending: income);
    print(b);
    mainbalance.value = b;
    mainbalance.notifyListeners();
    // refreshBudgetData(eventid);
    // refreshVendorData(eventid);
  } catch (e, stackTrace) {
    log('Error in refreshPaymentTypeData: $e\n$stackTrace');
  }
}
