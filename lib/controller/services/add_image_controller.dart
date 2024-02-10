// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sizer/sizer.dart';

// class ImageController extends GetxController {
//   Rx<File?> imageProfile = Rx<File?>(null);

//   Future<void> getImage(ImageSource source) async {
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) {
//         return;
//       }
//       imageProfile.value = File(image.path);
//       update(); // Update UI after selecting the image
//     } catch (e) {
//       // Handle error
//     }
//   }

//   void openDialog(void Function(String? imagePath) onSelectImage) {
//     Get.defaultDialog(
//       title: '',
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Choose Image From.......',
//             style: TextStyle(fontSize: 12.sp),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 onPressed: () async {
//                   await getImage(ImageSource.camera);
//                   Get.back();
//                   onSelectImage(imageProfile.value?.path);
//                 },
//                 icon: const Icon(
//                   Icons.camera_alt_rounded,
//                   color: Colors.red,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () async {
//                   await getImage(ImageSource.gallery);
//                   Get.back();
//                   onSelectImage(imageProfile.value?.path);
//                 },
//                 icon: const Icon(
//                   Icons.image,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:io';

// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';

// class ImagePickerController extends GetxController {
//   Rx<File?> imageFile = Rx<File?>(null);

//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image != null) {
//         imageFile.value = File(image.path);
//       }
//     } catch (e) {
//       // Handle error
//       print('Failed to pick image: $e');
//     }
//   }
// }
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
