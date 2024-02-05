import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/core/color/color.dart';
import 'package:project_event/main.dart';
import 'package:project_event/screen/body/widget/scaffold/bottomnavigator.dart';
import 'package:project_event/screen/intro/intro.dart';
import 'package:project_event/screen/intro/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/UI/Event Logo/event logo top.png',
            height: 50.h,
          ),
          const CircularProgressIndicator(
            color: appbarcolor,
          ),
        ],
      ),
    );
  }

  Future<void> checkUserLoggedIn(context) async {
    try {
      final sharedPrefer = await SharedPreferences.getInstance();
      final userlogged = sharedPrefer.getInt(logedinsp);
      final introcheck = sharedPrefer.getBool(introsp);

      if (userlogged == null) {
        log('goToLogin:   OnBoardingPage');
        if (introcheck == null || introcheck == false) {
          goToLogin(context);
        } else {
          await Future.delayed(const Duration(seconds: 1));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } else {
        await Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => MainBottom(profileid: userlogged)),
        );
      }
      // Rest of your code...
    } catch (e) {
      log('Error querying the database: $e');
    }
  }

  Future<void> goToLogin(context) async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnBoardingPage()),
    );
    log('goToLogin:   OnBoardingPage');
  }
}
