import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/data_model/payment/pay_model.dart';
import 'package:project_event/model/db_functions/fn_paymodel.dart';

void delectpayYes(
  PaymentModel student,
) {
  try {
    deletePayment(student.id, student.eventid, student.payid);
    Get.back();
    Get.back();

    Get.snackbar(
      'Great',
      "Successfully added",
      colorText: Colors.blueAccent,
      backgroundColor: Colors.greenAccent,
      duration: const Duration(milliseconds: 1100),
    );
  } catch (e) {
    // print('Error inserting data: $e');
  }
}
