import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/guest_event/guest_do_delect.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/guest_model/guest_model.dart';

void doDeleteGuest(GuestModel guest, int step, Eventmodel eventModel) {
  try {
    Get.defaultDialog(
      title: 'Delete',
      content: Text('Do you want to delete ${guest.gname}?'),
      actions: [
        TextButton(
          onPressed: () {
            deleteYes(guest, step, eventModel);
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
