import 'package:flutter/material.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';

class TextValidator {
  Widget emailTextField(TextEditingController controller) {
    return TextFieldBlue(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a valid email address';
          }
          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
              .hasMatch(value)) {
            return 'Enter a valid email address';
          }
          return null;
        },
        controller: controller,
        textcontent: 'Email ',
        keyType: TextInputType.emailAddress);
  }

  Widget cofirmpassword(
      {required TextEditingController confirmPassController,
      required TextEditingController passwordController}) {
    return TextFieldBlue(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      obscureText: true,
      textcontent: 'Confirm Password',
      controller: confirmPassController,
    );
  }

  Widget password({required TextEditingController passwordController}) {
    return TextFieldBlue(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 4) {
            return 'Password must be at least 4 characters long';
          }
          return null;
        },
        obscureText: true,
        textcontent: 'Password',
        controller: passwordController);
  }

  Widget phoneNumber({required TextEditingController phoneController}) {
    return TextFieldBlue(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid phone number';
        }
        final phoneNumberWithoutSpaces = value.replaceAll(' ', '');

        if (phoneNumberWithoutSpaces.startsWith('+') &&
            phoneNumberWithoutSpaces.length >= 13) {
          return null;
        } else if (!phoneNumberWithoutSpaces.startsWith('+') &&
            phoneNumberWithoutSpaces.length == 10) {
          return null;
        } else {
          return 'Enter a valid phone number';
        }
      },
      textcontent: 'Phone Number',
      keyType: TextInputType.number,
      controller: phoneController,
    );
  }

  Widget nameController({required TextEditingController nameController}) {
    return TextFieldBlue(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Name';
        }
        if (value.length >= 16) {
          return "Name is too long";
        }
        return null;
      },
      textcontent: 'Full Name',
      keyType: TextInputType.name,
      controller: nameController,
    );
  }

  Widget normal(
      {required TextEditingController controller,
      required String textcontent}) {
    return TextFieldBlue(
      keyType: TextInputType.streetAddress,
      controller: controller,
      textcontent: 'Address',
      posticondata: Icons.location_on,
    );
  }
}
