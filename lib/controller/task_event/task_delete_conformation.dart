import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/task_event/task_do_delete.dart';

import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/task/task_model.dart';

void doDeleteTask(TaskModel task, int step, Eventmodel eventModel) {
  try {
    Get.defaultDialog(
      title: 'Delete',
      content: Text('Do you want to delete ${task.taskname}?'),
      actions: [
        TextButton(
          onPressed: () {
            delectYes(task, step, eventModel);
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
