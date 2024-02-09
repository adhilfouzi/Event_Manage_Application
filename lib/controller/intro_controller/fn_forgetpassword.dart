import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';

Future<void> setProfileclick(formKey, TextEditingController passwordse,
    TextEditingController email) async {
  // ProfileController controller = Get.put(ProfileController());
  if (formKey.currentState != null && formKey.currentState!.validate()) {
    final password = passwordse.text;

    final existingProfiles = profileList.value
        .where((profile) => profile.email == email.text)
        .toList();
    if (existingProfiles.isEmpty) {
      SnackbarModel.errorSnack(
          message: 'Email not registered. Please sign up.');
      return;
    }
    await editProfiledata(
        existingProfiles.first.id!,
        existingProfiles.first.imagex!,
        existingProfiles.first.name,
        existingProfiles.first.email,
        existingProfiles.first.phone,
        existingProfiles.first.address ?? '',
        password);
    Get.back();
    SnackbarModel.successSnack(message: 'Password Reset Successfully');
  }
}
