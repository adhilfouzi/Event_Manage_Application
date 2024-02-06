import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_event/controller/vendor_event/vendor_do_delete.dart';

import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/vendors/vendors_model.dart';

void doDeleteVendor(VendorsModel vendor, int step, Eventmodel eventModel) {
  try {
    Get.defaultDialog(
      title: 'Delete',
      content: Text('Do you want to delete ${vendor.name}?'),
      actions: [
        TextButton(
          onPressed: () {
            deleteYes(vendor, step, eventModel);
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
