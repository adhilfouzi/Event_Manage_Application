import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/Screen/Drawer/appinfo.dart';
import 'package:project_event/screen/Body/Screen/Drawer/calender.dart';
import 'package:project_event/screen/Body/Screen/Drawer/favorite.dart';
import 'package:project_event/screen/Body/Screen/Drawer/feedback.dart';
import 'package:project_event/screen/Body/Screen/Drawer/privacy.dart';
import 'package:project_event/screen/Body/Screen/Drawer/reset.dart';
import 'package:project_event/screen/Body/Screen/Drawer/terms.dart';
import 'package:project_event/screen/Body/widget/List/listtiledrawer.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
import 'package:sizer/sizer.dart';

class ProfileAccount extends StatelessWidget {
  const ProfileAccount({Key? key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainBottom(),
          ),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(actions: [], titleText: 'Profile'),
        body: Padding(
          padding: EdgeInsets.all(1.h),
          child: Column(
            children: [
              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 20.h,
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/UI/icons/profile.png'),
                        radius: 50.0,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 2.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Abhishek Mishra",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            "abhishekmishra@gmail.com",
                            style: TextStyle(fontSize: 8.sp),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      ListTileDrawer(
                        map: Privacy(),
                        imagedata: 'assets/UI/icons/icons8-settings-500.png',
                        textdata: 'Settings++++',
                      ),
                      SizedBox(height: 2.h),
                      ListTileDrawer(
                        map: Favorite(),
                        imagedata: 'assets/UI/icons/favorite.png',
                        textdata: 'Favorite',
                      ),
                      SizedBox(height: 2.h),
                      ListTileDrawer(
                        map: Calender(),
                        imagedata: 'assets/UI/icons/calendar.png',
                        textdata: 'Calendar',
                      ),
                      SizedBox(height: 2.h),
                      ListTileDrawer(
                        map: AppInfo(),
                        imagedata: 'assets/UI/icons/about us.png',
                        textdata: 'App info',
                      ),
                      SizedBox(height: 2.h),
                      ListTileDrawerEmail(),
                      SizedBox(height: 2.h),
                      ListTileDrawer(
                        map: Privacy(),
                        imagedata: 'assets/UI/icons/privacy.png',
                        textdata: 'Privacy',
                      ),
                      SizedBox(height: 2.h),
                      ListTileDrawer(
                        map: Terms(),
                        imagedata: 'assets/UI/icons/terms of service.png',
                        textdata: 'Terms of Service',
                      ),
                      SizedBox(height: 2.h),
                      ListTileDrawer(
                        map: Reset(),
                        imagedata: 'assets/UI/icons/backup.png',
                        textdata: 'Reset Data',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
