import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/intro/loginpage.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Text(
                  'Make it perfect !',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: buttoncolor),
                ),
                SizedBox(height: 7.h),
                Image.asset(
                  'assets/UI/image/template/pass.png',
                  height: 25.h,
                  width: 90.w,
                ),
                SizedBox(height: 10.h),
                const TextFieldBlue(
                  obscureText: true,
                  textcontent: 'Password',
                ),
                SizedBox(height: 1.5.h),
                const TextFieldBlue(
                  obscureText: true,
                  textcontent: 'Confirm Password',
                ),
                SizedBox(height: 1.5.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: firstbutton(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Signup',
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
    );
  }
}
