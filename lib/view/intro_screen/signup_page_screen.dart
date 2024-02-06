import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/core/color/color.dart';

import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/model/data_model/profile/profile_model.dart';
import 'package:project_event/view/body_screen/profile/privacy_function_screen.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/view/intro_screen/loginpage_screen.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkboxValue = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    refreshRefreshdata();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.h),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 7.h),
                  SizedBox(
                    height: 11.h,
                    child: Text(
                      'Let’s Begin the game',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: buttoncolor,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFieldBlue(
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
                      ),
                      SizedBox(height: 1.h),
                      ValueListenableBuilder(
                        valueListenable: profileList,
                        builder: (context, valueList, child) => TextFieldBlue(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid email address';
                            }
                            if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                .hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          textcontent: 'Email',
                          keyType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      TextFieldBlue(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid phone number';
                          }
                          final phoneNumberWithoutSpaces =
                              value.replaceAll(' ', '');

                          if (phoneNumberWithoutSpaces.startsWith('+') &&
                              phoneNumberWithoutSpaces.length >= 13) {
                            return null;
                          } else if (!phoneNumberWithoutSpaces
                                  .startsWith('+') &&
                              phoneNumberWithoutSpaces.length == 10) {
                            return null;
                          } else {
                            return 'Enter a valid phone number';
                          }
                        },
                        textcontent: 'Phone Number',
                        keyType: TextInputType.number,
                        controller: phoneController,
                      ),
                      SizedBox(height: 1.h),
                      TextFieldBlue(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }

                          return null;
                        },
                        obscureText: true,
                        textcontent: 'Password',
                        controller: passwordController,
                      ),
                      SizedBox(height: 1.h),
                      TextFieldBlue(
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: checkboxValue,
                            onChanged: (bool? value) {
                              setState(() {
                                checkboxValue = value!;
                              });
                            },
                          ),
                          InkWell(
                            onTap: launchPrivacyPolicy,
                            child: Text(
                              'I agree with Terms and Privacy ',
                              style: TextStyle(
                                color: buttoncolor,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: firstbutton(),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  addProfileclick(context);
                                }
                              },
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account -',
                            style: TextStyle(
                              color: buttoncolor,
                              fontSize: 10.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.off(
                                  transition: Transition.leftToRightWithFade,
                                  const LoginScreen());
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: buttoncolor,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addProfileclick(mtx) async {
    if (_formKey.currentState != null &&
        _formKey.currentState!.validate() &&
        checkboxValue == true) {
      try {
        final existingProfiles = profileList.value
            .where((profile) => profile.email == emailController.text)
            .toList();

        if (existingProfiles.isNotEmpty) {
          ScaffoldMessenger.of(mtx).showSnackBar(
            const SnackBar(
              content: Text('This email is already registered'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final profile = ProfileModel(
          name: nameController.text.toUpperCase(),
          email: emailController.text.toLowerCase().trim(),
          phone: phoneController.text.trimLeft().trimRight(),
          password: passwordController.text,
        );
        ScaffoldMessenger.of(mtx).showSnackBar(
          const SnackBar(
            content: Text('Sign up Successfully'),
            backgroundColor: Colors.green,
          ),
        );

        await addProfile(profile);
        await refreshRefreshdata();
        Get.off(
            transition: Transition.leftToRightWithFade, const LoginScreen());
      } catch (e) {
        log('Error inserting data: $e');
      }
    }
  }
}
