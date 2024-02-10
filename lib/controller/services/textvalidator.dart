import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';

class TextValidator {
  Widget emailTextField(TextEditingController controller, {bool bool = false}) {
    return TextFieldBlue(
        validator: (value) {
          if (bool) {
            if (value!.isNotEmpty) {
              if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                  .hasMatch(value)) {
                return 'Enter a valid email address';
              }
            }
          } else {
            if (value!.isEmpty) {
              return 'Please enter a valid email address';
            }
            if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                .hasMatch(value)) {
              return 'Enter a valid email address';
            }
          }

          return null;
        },
        controller: controller,
        posticondata: Icons.email,
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

  Widget phoneNumber(
      {required TextEditingController phoneController, bool bool = false}) {
    return TextFieldBlue(
      validator: (value) {
        if (bool) {
          if (value!.isNotEmpty) {
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
          }
        } else {
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
        }
        return null;
      },
      textcontent: 'Phone Number',
      keyType: TextInputType.number,
      controller: phoneController,
      posticondata: Icons.call,
    );
  }

  Widget nameController({
    required TextEditingController nameController,
  }) {
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

  // void onNumberChanged(String value) {
  //   String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
  //   final formatValue = _formatCurrency(numericValue);
  //   budgetController.value = budgetController.value.copyWith(
  //     text: formatValue,
  //     selection: TextSelection.collapsed(offset: formatValue.length),
  //   );
  // }

  String _formatCurrency(String value) {
    if (value.isNotEmpty) {
      final format = NumberFormat("#,##0", "en_US");
      return format.format(int.parse(value));
    } else {
      return value;
    }
  }

  Widget budget({required TextEditingController budgetController}) {
    return TextFieldBlue(
      onChanged: (value) {
        String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
        final formatValue = _formatCurrency(numericValue);
        budgetController.value = budgetController.value.copyWith(
          text: formatValue,
          selection: TextSelection.collapsed(offset: formatValue.length),
        );
      },
      keyType: TextInputType.number,
      textcontent: 'Budget',
      controller: budgetController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  Widget normal(
      {required TextEditingController controller,
      required String textcontent}) {
    return TextFieldBlue(
      keyType: TextInputType.streetAddress,
      controller: controller,
      textcontent: textcontent,
    );
  }

  Widget place(
      {required TextEditingController controller,
      required String textcontent,
      bool bool = false}) {
    return TextFieldBlue(
      validator: (value) {
        if (bool) {
          if (value!.isEmpty) {
            return 'Please enter a Venue';
          }
        }

        return null;
      },
      keyType: TextInputType.streetAddress,
      controller: controller,
      textcontent: textcontent,
      posticondata: Icons.location_on,
    );
  }
}
