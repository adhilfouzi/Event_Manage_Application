import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/intro/forgetpassword.dart';
import 'package:project_event/screen/intro/signup_page.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 5.h),
              SizedBox(
                height: 10.h,
                child: Text(
                  'Welcome Back !',
                  style: TextStyle(
                      fontSize: 3.5.h,
                      fontWeight: FontWeight.bold,
                      color: buttoncolor),
                ),
              ),
              //SizedBox(height: 5.h),
              Image.asset(
                'assets/UI/image/template/login.png',
                height: 20.h,
                width: 90.w,
              ),
              SizedBox(height: 5.h),
              Container(
                height: 50.h,
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.bottomCenter,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const TextFieldBlue(
                        textcontent: 'Email ',
                        keyType: TextInputType.emailAddress),
                    const SizedBox(height: 5),
                    const TextFieldBlue(
                        obscureText: true,
                        textcontent: 'Password',
                        keyType: TextInputType.emailAddress),
                    // const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ForgetPassword(),
                            ),
                          );
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
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const MainBottom(),
                                  ),
                                  (route) => false);
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.sp)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h),
                    const Text('If you are new here',
                        style: TextStyle(color: buttoncolor)),
                    SizedBox(height: 1.5.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: secbutton(),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
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

ButtonStyle firstbutton() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.5.h)),
    side: MaterialStateProperty.all(BorderSide.none),
    backgroundColor: MaterialStateProperty.all(buttoncolor),
  );
}

ButtonStyle secbutton() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.5.h)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )),
  );
}
