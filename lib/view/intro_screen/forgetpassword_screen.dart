import 'package:flutter/material.dart';
import 'package:project_event/controller/intro_controller/fn_forgetpassword.dart';
import 'package:project_event/controller/intro_controller/login_button.dart';
import 'package:project_event/controller/services/textvalidator.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    final TextEditingController emailController = TextEditingController();

    final TextEditingController confirmPassController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.h),
              child: Form(
                key: formKey,
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
                      height: 35.h,
                      width: 90.w,
                    ),
                    SizedBox(height: 3.h),
                    TextValidator().emailTextField(emailController),
                    TextValidator()
                        .password(passwordController: passwordController),
                    SizedBox(height: 1.5.h),
                    TextValidator().cofirmpassword(
                        confirmPassController: confirmPassController,
                        passwordController: passwordController),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: firstbutton(),
                            onPressed: () {
                              setProfileclick(
                                  formKey, passwordController, emailController);
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
}
