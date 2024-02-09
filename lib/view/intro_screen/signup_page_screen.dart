import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/intro_controller/fn_signup.dart';
import 'package:project_event/controller/intro_controller/login_button.dart';
import 'package:project_event/controller/services/textvalidator.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/view/body_screen/profile/privacy_function_screen.dart';
import 'package:project_event/view/intro_screen/loginpage_screen.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    SignupController check = Get.put(SignupController());
    // bool checkboxValue = false;
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    // ProfileController controller = Get.put(ProfileController());
    // controller.refreshProfileData();
    refreshRefreshdata();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(1.h),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 7.h),
                SizedBox(
                  height: 11.h,
                  child: Text(
                    "Let's Begin the game",
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
                    TextValidator()
                        .nameController(nameController: nameController),
                    SizedBox(height: 1.h),
                    TextValidator().emailTextField(emailController),
                    SizedBox(height: 1.h),
                    TextValidator()
                        .phoneNumber(phoneController: phoneController),
                    SizedBox(height: 1.h),
                    TextValidator()
                        .password(passwordController: passwordController),
                    SizedBox(height: 1.h),
                    TextValidator().cofirmpassword(
                        confirmPassController: confirmPassController,
                        passwordController: passwordController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => check.checkBox(),
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
                              if (formKey.currentState?.validate() ?? false) {
                                SignupController().addProfileClick(
                                    formKey,
                                    check.checkboxValue.value,
                                    emailController,
                                    nameController,
                                    phoneController,
                                    passwordController);
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
    );
  }
}
