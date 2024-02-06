import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/settlement_event/income_controller/income_do_delect.dart';

import 'package:project_event/model/data_model/payment/pay_model.dart';

void doDeleteIncome(IncomeModel income) {
  try {
    Get.defaultDialog(
      title: 'Delete',
      content: Text('Do you want to delete payment by ${income.name}?'),
      actions: [
        TextButton(
          onPressed: () {
            delectpayYes(income);
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
