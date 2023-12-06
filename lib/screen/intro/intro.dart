import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';

import 'package:project_event/screen/intro/entry.dart';
import 'package:sizer/sizer.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final List<Introduction> list = [
    Introduction(
      title: 'Effortless Event Planning',
      subTitle: '',
      imageUrl: 'assets/UI/image/template/1-03.png',
      imageWidth: 80.w,
      imageHeight: 50.h,
      titleTextStyle: TextStyle(fontSize: 12.sp),
      subTitleTextStyle: TextStyle(fontSize: 1.sp),
    ),
    Introduction(
      title: 'Time-Saving Solution',
      subTitle: '',
      imageUrl: 'assets/UI/image/template/1-01.png',
      imageWidth: 80.w,
      imageHeight: 50.h,
      titleTextStyle: TextStyle(fontSize: 12.sp),
      subTitleTextStyle: TextStyle(fontSize: 1.sp),
    ),
    Introduction(
      title: 'Make Work Smart',
      subTitle: '',
      imageUrl: 'assets/UI/image/template/1-02.png',
      imageWidth: 80.w,
      imageHeight: 50.h,
      titleTextStyle: TextStyle(fontSize: 12.sp),
      subTitleTextStyle: TextStyle(fontSize: 1.sp),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      backgroudColor: const Color(0xFFf9f9f9),
      foregroundColor: const Color(0xFFFFAA00),
      introductionList: list,
      onTapSkipButton: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Entry(),
          )),
      skipTextStyle: TextStyle(
        color: Colors.blueGrey,
        fontSize: 15.sp,
      ),
    );
  }
}
