import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:sizer/sizer.dart';

class NotificationBar extends StatelessWidget {
  const NotificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [],
        titleText: 'Update',
      ),
      body: Center(
          child: Text(
        'No Updates Available',
        style: TextStyle(fontSize: 15.sp),
      )),
    );
  }
}
