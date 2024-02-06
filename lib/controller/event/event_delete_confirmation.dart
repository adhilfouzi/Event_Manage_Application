import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event/event_do_delect.dart';
import 'package:project_event/model/data_model/event/event_model.dart';

void doDeleteEvent(Eventmodel event) {
  try {
    Get.defaultDialog(
      title: 'Delete',
      content: Text(
        'Do you want to delete ${event.eventname} of ${event.clientname}?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            deleteEventYes(event);
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
