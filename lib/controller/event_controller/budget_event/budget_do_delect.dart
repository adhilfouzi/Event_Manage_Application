import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/budget_event/budget_delete_confirmation.dart';

import 'package:project_event/model/data_model/budget_model/budget_model.dart';
import 'package:project_event/model/data_model/event/event_model.dart';

void doDeleteBudget(
  BudgetModel budget,
  int step,
  Eventmodel eventModel,
) {
  try {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete'),
        content: Text('Do You Want to delete ${budget.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              delectYes(budget, step, eventModel);
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
      ),
    );
  } catch (e) {
    // print('Error deleting data: $e');
  }
}
