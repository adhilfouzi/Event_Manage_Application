import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project_event/model/db_functions/fn_evenmodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';
import 'package:project_event/view/body_screen/main/main_screem.dart';

class AddEventController extends GetxController {
  final int profileid;
  final formKey = GlobalKey<FormState>();
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final Rx<File?> imageEvent = Rx<File?>(null);
  RxBool hasClient = false.obs;

  AddEventController(this.profileid);

  @override
  void onClose() {
    super.onClose();
    eventNameController.dispose();
    budgetController.dispose();
    locationController.dispose();
    aboutController.dispose();
    clientNameController.dispose();
    startDateController.dispose();
    startTimeController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  void onBudgetChanged(String value) {
    String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    final formatValue = _formatCurrency(numericValue);
    budgetController.value = budgetController.value.copyWith(
      text: formatValue,
      selection: TextSelection.collapsed(offset: formatValue.length),
    );
  }

  String _formatCurrency(String value) {
    if (value.isNotEmpty) {
      final format = NumberFormat("#,##0", "en_US");
      return format.format(int.parse(value));
    } else {
      return value;
    }
  }

  Future<void> getContact() async {
    try {
      bool permission = await FlutterContactPicker.requestPermission();
      if (permission) {
        if (await FlutterContactPicker.hasPermission()) {
          PhoneContact? phoneContact =
              await FlutterContactPicker.pickPhoneContact();

          if (phoneContact.fullName!.isNotEmpty) {
            clientNameController.text = phoneContact.fullName!;
          }
          if (phoneContact.phoneNumber!.number!.isNotEmpty) {
            phoneNumberController.text = phoneContact.phoneNumber!.number!;
          }
        }
      }
    } catch (e) {
      if (e is UserCancelledPickingException) {
        // Handle the cancellation
      } else {
        // Handle other exceptions
      }
    }
  }

  Future<void> addPhoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
        ],
        uiSettings: [
          AndroidUiSettings(
            lockAspectRatio: true,
            toolbarTitle: 'Crop',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
          ),
          IOSUiSettings(
            title: 'Crop',
          ),
        ],
      );
      if (croppedFile != null) {
        imageEvent.value = File(croppedFile.path);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addEventClicked() async {
    if (imageEvent.value == null) {
      SnackbarModel.errorSnack(message: 'Add Profile Picture');
      return;
    }
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      if (eventNameController.text.toUpperCase().isNotEmpty &&
          locationController.text.toUpperCase().isNotEmpty) {
        final event = Eventmodel(
          eventname: eventNameController.text.toUpperCase(),
          location: locationController.text.toUpperCase(),
          startingDay: startDateController.text,
          startingTime: startTimeController.text,
          imagex: imageEvent.value!.path,
          favorite: 0,
          profile: profileid,
          about: aboutController.text.trimLeft().trimRight(),
          address: addressController.text.trimLeft().trimRight(),
          budget: budgetController.text.trim(),
          emailId: emailController.text.trim().toLowerCase(),
          clientname: clientNameController.text.toUpperCase(),
          phoneNumber: phoneNumberController.text.trim(),
        );

        await addEvent(event);
        Get.offAll(
          fullscreenDialog: true,
          MainBottom(profileid: profileid),
        );
        SnackbarModel.successSnack();
      }
    }
  }
}
