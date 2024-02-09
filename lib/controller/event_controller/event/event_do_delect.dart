import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/db_functions/fn_evenmodel.dart';
import 'package:project_event/view/body_screen/main/main_screem.dart';

void deleteEventYes(
  Eventmodel student,
) {
  deleteEventdata(student.id, student.profile);
  Get.offAll(
      transition: Transition.leftToRightWithFade,
      //     allowSnapshotting: false,
      fullscreenDialog: true,
      MainBottom(profileid: student.profile));
  Get.snackbar(
    'Great',
    "Successfully Deleted",
    backgroundColor: Colors.grey,
    duration: const Duration(milliseconds: 1100),
  );
}
