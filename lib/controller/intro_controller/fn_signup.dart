import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/data_model/profile/profile_model.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';
import 'package:project_event/view/intro_screen/loginpage_screen.dart';

class SignupController extends GetxController {
  RxBool checkboxValue = false.obs;
  // ProfileController controller = Get.put(ProfileController());
  Future<void> addProfileClick(
      formKey,
      bool checkboxValue,
      TextEditingController email,
      TextEditingController name,
      TextEditingController phone,
      TextEditingController password) async {
    if (formKey.currentState != null &&
        formKey.currentState!.validate() &&
        checkboxValue == true) {
      try {
        final existingProfiles = profileList.value
            .where((profile) => profile.email == email.text)
            .toList();

        if (existingProfiles.isNotEmpty) {
          SnackbarModel.errorSnack(message: 'This email is already registered');
          return;
        }

        final profile = ProfileModel(
          name: name.text.trim().toUpperCase(),
          email: email.text.trim().toLowerCase(),
          phone: phone.text.trim(),
          password: password.text,
        );

        await addProfile(profile);
        await refreshRefreshdata();

        SnackbarModel.successSnack(message: 'Sign up Successfully');

        Get.off(
          transition: Transition.leftToRightWithFade,
          const LoginScreen(),
        );
      } catch (e) {
        SnackbarModel.errorSnack(
            message: 'Error occurred. Please try again later.');
      }
    } else {
      SnackbarModel.errorSnack(
          message: 'Please fill all required fields and accept terms.');
    }
  }

  Widget checkBox() {
    return Checkbox(
      value: checkboxValue.value,
      onChanged: (bool? value) {
        log(value.toString());
        checkboxValue.value = value!;
      },
    );
  }
}
