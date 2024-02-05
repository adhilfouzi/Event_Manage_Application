import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/screen/intro/loginpage.dart';
import 'package:project_event/screen/intro/signup_page.dart';
import 'package:sizer/sizer.dart';

class Entry extends StatelessWidget {
  const Entry({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/UI/image/entry.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text at the top center
          Column(
            // Use Column instead of Expanded
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 110, 16, 16),
                  child: Text(
                    'Event Time',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Buttons at the bottom center
          Container(
            padding: EdgeInsets.fromLTRB(2.h, 65.h, 2.h, 10.h),
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Text(
                  'Life is only once, Enjoy your life!',
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: withr,
                        onPressed: () {
                          Get.off(const SignupScreen());
                        },
                        child: Text('Signup',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.sp)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                const Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: withr,
                        onPressed: () {
                          Get.off(const LoginScreen());
                        },
                        child: Text('Login',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.sp)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

ButtonStyle withr = ButtonStyle(
  padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.5.h)),
  side:
      MaterialStateProperty.all(BorderSide(color: Colors.white, width: 0.3.h)),
  backgroundColor: MaterialStateProperty.all(Colors.transparent),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  )),
);
