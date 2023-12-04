import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Database/functions/fn_profilemodel.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/intro/forgetpassword.dart';
import 'package:project_event/screen/intro/signup_page.dart';
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen(),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginclick(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      final existingProfiles =
          profileList.value.where((profile) => profile.email == email).toList();

      if (existingProfiles.isNotEmpty) {
        final matchingProfile = existingProfiles.first;
        if (matchingProfile.password == password) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MainBottom(profileid: matchingProfile.id!),
            ),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect password. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not registered. Please sign up.'),
            backgroundColor: Colors.red,
          ),
        );
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
