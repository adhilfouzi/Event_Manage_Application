// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
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
    final result = await paymentDB.rawQuery(
        "SELECT * FROM payment WHERE eventid = ? AND paytype = 0 AND payid = ?",
        [payid.toString(), eventid.toString()]);
    print('All budgetPayment data: $result');
    budgetPaymentDetails.value.clear();
    for (var map in result) {
      final student = PaymentModel.fromMap(map);
      budgetPaymentDetails.value.add(student);
    }

    budgetPaymentDetails.notifyListeners();

    ///-----------------------------------------
    ///-----------------------------------------

    final resultven = await paymentDB.rawQuery(
        "SELECT * FROM payment WHERE eventid = ? AND paytype = 1 AND payid = ?",
        [payid.toString()]);
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