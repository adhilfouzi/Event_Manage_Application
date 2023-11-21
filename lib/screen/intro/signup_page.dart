import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/intro/loginpage.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(1.50.h),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Text(
                  'Let’s Begin the game',
                  style: TextStyle(
                      fontSize: 3.5.h,
                      fontWeight: FontWeight.bold,
                      color: buttoncolor),
                ),
                SizedBox(height: 5.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const TextFieldBlue(
                        textcontent: 'Full Name', keyType: TextInputType.name),
                    SizedBox(height: 1.5.h),
                    const TextFieldBlue(
                        textcontent: 'Email',
                        keyType: TextInputType.emailAddress),
                    SizedBox(height: 1.5.h),
                    const TextFieldBlue(
                        textcontent: 'Phone Number',
                        keyType: TextInputType.number),
                    SizedBox(height: 1.5.h),
                    const TextFieldBlue(
                      obscureText: true,
                      textcontent: 'Password',
                    ),
                    SizedBox(height: 1.5.h),
                    const TextFieldBlue(
                      obscureText: true,
                      textcontent: 'Confirm Password',
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
                        Text(
                          'I agree with Terms and Privacy ',
                          style:
                              TextStyle(color: buttoncolor, fontSize: 1.52.h),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: firstbutton(),
                            onPressed: () {
                              if (checkboxValue == true) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              } else {
                                return;
                              }
                            },
                            child: Text('Signup',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 2.5.h)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account -',
                          style:
                              TextStyle(color: buttoncolor, fontSize: 1.52.h),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style:
                                TextStyle(color: buttoncolor, fontSize: 1.52.h),
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
