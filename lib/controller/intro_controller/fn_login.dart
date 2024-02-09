import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/main.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';
import 'package:project_event/view/body_screen/main/main_screem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenFn {
  Future<void> loginClick(formKey, TextEditingController email,
      TextEditingController password) async {
    // ProfileController controller = Get.put(ProfileController());
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final existingProfiles = profileList.value
          .where((profile) => profile.email == email.text)
          .toList();

      if (existingProfiles.isNotEmpty) {
        final matchingProfile = existingProfiles.first;
        if (matchingProfile.password == password.text) {
          // Navigate to the main screen after successful login
          Get.offAll(
            transition: Transition.leftToRightWithFade,
            MainBottom(profileid: matchingProfile.id!),
          );

          // Store the logged-in user's ID in SharedPreferences
          final sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setInt(logedinsp, matchingProfile.id!);
        } else {
          // Display error message for incorrect password
          SnackbarModel.errorSnack(
              message: 'Incorrect password. Please try again.');
        }
      } else {
        // Display error message for unregistered email
        SnackbarModel.errorSnack(
            message: 'Email not registered. Please sign up.');
      }
    }
  }
}
