import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ImageController extends GetxController {
  Rx<File?> imageProfile = Rx<File?>(null);
  late Rx<String?> imagePath;

  ImageController(String? initialImagePath) {
    imagePath = Rx<String?>(initialImagePath ?? '');
    if (initialImagePath != null) {
      imageProfile.value = File(initialImagePath);
    }
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      imageProfile.value = File(image.path);
      imagePath.value = image.path;
    } catch (e) {
      // Handle error
    }
  }

  void openDialog() {
    Get.defaultDialog(
      title: '',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose Image From.......',
            style: TextStyle(fontSize: 12.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                  Get.back();
                },
                icon: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                  Get.back();
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
