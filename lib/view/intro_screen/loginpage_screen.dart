import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/intro_controller/fn_login.dart';
import 'package:project_event/controller/intro_controller/login_button.dart';
import 'package:project_event/controller/services/textvalidator.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/view/intro_screen/forgetpassword_screen.dart';
import 'package:project_event/view/intro_screen/signup_page_screen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    // ProfileController controller = Get.put(ProfileController());
    // controller.refreshProfileData();
    refreshRefreshdata();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
              Container(
                padding: EdgeInsets.all(2.h),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    TextValidator().emailTextField(emailController),
                    SizedBox(height: 1.h),
                    TextValidator()
                        .password(passwordController: passwordController),
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
                              LoginScreenFn().loginClick(
                                  formKey, emailController, passwordController);
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
                                  transition: Transition.rightToLeftWithFade,
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
            ],
          ),
        ),
      ),
    );
  }
}
