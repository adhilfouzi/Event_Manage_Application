import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/settlement_event/payment_controller/payment_do_delete.dart';

import 'package:project_event/model/data_model/payment/pay_model.dart';

void doDeletePayment(PaymentModel payment) {
  try {
    Get.defaultDialog(
      title: 'Delete',
      content: Text('Do you want to delete payment by ${payment.name}?'),
      actions: [
        TextButton(
          onPressed: () {
            delectpayYes(payment);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
      ],
    );
  } catch (e) {
    // Handle error if necessary
    // print('Error deleting data: $e');
  }
}
