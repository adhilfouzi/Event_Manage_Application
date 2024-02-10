import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/data_model/profile/profile_model.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';

class Profile {
  static Future editProfileController(
      formKey,
      ProfileModel profile,
      TextEditingController name,
      TextEditingController email,
      TextEditingController phone,
      TextEditingController? address,
      String? imagepath) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final existingProfiles = profileList.value
          .where((profile) => profile.email == email.text)
          .toList();

      if (email.text != profile.email) {
        if (existingProfiles.isNotEmpty) {
          SnackbarModel.errorSnack(message: 'This email is already registered');
          return;
        }
      }

      if (imagepath == null) {
        SnackbarModel.errorSnack(message: 'Forgot to add an image');
        return;
      }

      await editProfiledata(
        profile.id,
        imagepath,
        name.text.toUpperCase(),
        email.text.toLowerCase(),
        phone.text,
        address!.text,
        profile.password,
      );

      refreshRefreshid(profile.id!);
      Get.back();
    }
  }
}
