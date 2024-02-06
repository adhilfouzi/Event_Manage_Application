import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/main.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';
import 'package:project_event/view/body_screen/main/main_screem.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/view/intro_screen/forgetpassword_screen.dart';
import 'package:project_event/view/intro_screen/signup_page_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    refreshRefreshdata();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 4.h),
                SizedBox(
                  height: 5.h,
                  child: Text(
                    'Welcome Back !',
                    style: TextStyle(
                        fontSize: 3.5.h,
                        fontWeight: FontWeight.bold,
                        color: buttoncolor),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                  child: Image.asset(
                    'assets/UI/image/template/login.png',
                    height: 20.h,
                    width: 90.w,
                  ),
                ),
                //SizedBox(height: 3.h),
                Container(
                  padding: EdgeInsets.all(2.h),
                  alignment: Alignment.bottomCenter,
                  child: ValueListenableBuilder(
                    valueListenable: profileList,
                    builder: (context, valueList, child) => Column(
                      children: [
                        TextFieldBlue(
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
                            controller: passwordController,
                            textcontent: 'Password',
                            keyType: TextInputType.emailAddress),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.to(
                                  transition: Transition.rightToLeftWithFade,
                                  const ForgetPassword());
                            },
                            child: const Text(
                              'Forget your password ?',
                              style: TextStyle(color: buttoncolor),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: firstbutton(),
                                onPressed: () {
                                  loginclick(context);
                                },
                                child: Text('Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.sp)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        const Text('If you are new here',
                            style: TextStyle(color: buttoncolor)),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: secbutton(),
                                onPressed: () {
                                  Get.to(
                                      transition:
                                          Transition.rightToLeftWithFade,
                                      const SignupScreen());
                                },
                                child: Text('Signup',
                                    style: TextStyle(
                                        color: buttoncolor, fontSize: 15.sp)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginclick(BuildContext context) async {
    SnackbarModel ber = SnackbarModel();

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      final existingProfiles =
          profileList.value.where((profile) => profile.email == email).toList();

      if (existingProfiles.isNotEmpty) {
        final matchingProfile = existingProfiles.first;
        if (matchingProfile.password == password) {
          Get.offAll(
              transition: Transition.leftToRightWithFade,
              MainBottom(profileid: matchingProfile.id!));

          final sharedPrefer = await SharedPreferences.getInstance();
          await sharedPrefer.setInt(logedinsp, matchingProfile.id!);
        } else {
          ber.errorSnack(message: 'Incorrect password. Please try again.');
        }
      } else {
        ber.errorSnack(message: 'Email not registered. Please sign up.');
      }
    }
  }
}

ButtonStyle firstbutton() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    side: MaterialStateProperty.all(BorderSide.none),
    backgroundColor: MaterialStateProperty.all(buttoncolor),
  );
}

ButtonStyle secbutton() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )),
  );
}
