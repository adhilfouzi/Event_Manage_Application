import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarModel {
  void errorSnack({String? message}) {
    Get.snackbar('Warning', message ?? 'Please fill all required fields',
        colorText: Colors.black,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        instantInit: false,
        duration: const Duration(milliseconds: 1100),
        dismissDirection: DismissDirection.startToEnd);
  }

  void successSnack({String? message}) {
    Get.snackbar(
      'Great',
      message ?? "Successfully added",
      colorText: Colors.blueAccent,
      backgroundColor: Colors.greenAccent,
      duration: const Duration(milliseconds: 1100),
    );
  }
}
