import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Database/functions/fn_profilemodel.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/intro/loginpage.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.h),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      'Make it perfect !',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: buttoncolor),
                    ),
                    SizedBox(height: 2.h),
                    Image.asset(
                      'assets/UI/image/template/pass.png',
                      height: 25.h,
                      width: 90.w,
                    ),
                    SizedBox(height: 3.h),
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
                          controller: emailController,
                          textcontent: 'Email ',
                          keyType: TextInputType.emailAddress),
                    ),
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
                        controller: passwordController),
                    SizedBox(height: 1.5.h),
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
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: firstbutton(),
                            onPressed: () {
                              setProfileclick(context);
                            },
                            child: Text('Set',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.sp)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setProfileclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final password = passwordController.text;

      final existingProfiles = profileList.value
          .where((profile) => profile.email == emailController.text)
          .toList();
      if (existingProfiles.isEmpty) {
        ScaffoldMessenger.of(mtx).showSnackBar(
          const SnackBar(
            content: Text('Email not registered. Please sign up.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      await editProfiledata(
          existingProfiles.first.id,
          existingProfiles.first.imagex,
          existingProfiles.first.name,
          existingProfiles.first.email,
          existingProfiles.first.phone,
          existingProfiles.first.address,
          password);
      Navigator.of(mtx).pop();
    }
  }
}
