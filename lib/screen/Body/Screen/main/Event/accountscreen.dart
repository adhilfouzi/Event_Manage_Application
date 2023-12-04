import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Database/functions/fn_profilemodel.dart';
import 'package:project_event/screen/Body/Screen/profile/appinfo.dart';
import 'package:project_event/screen/Body/Screen/profile/favorite.dart';
import 'package:project_event/screen/Body/Screen/profile/feedback.dart';
import 'package:project_event/screen/Body/Screen/profile/reset.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_profile.dart';
import 'package:project_event/screen/Body/widget/List/listtiledrawer.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
import 'package:sizer/sizer.dart';

class ProfileAccount extends StatelessWidget {
  final int profileid;

  const ProfileAccount({super.key, required this.profileid});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainBottom(profileid: profileid),
          ),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: const CustomAppBar(actions: [], titleText: 'Profile'),
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
                  //  height: 20.h,
                  padding: EdgeInsets.fromLTRB(1.h, 1.h, 1.h, 1.h),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: profileData,
                        builder: (context, value, child) => Container(
                          padding: EdgeInsets.fromLTRB(2.h, 2.h, 2.h, 1.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: value.first.imagex != null
                                    ? FileImage(File(value.first.imagex!))
                                    : const AssetImage(
                                            'assets/UI/icons/profile.png')
                                        as ImageProvider,
                                radius: 50.0,
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(width: 1.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    value.first.name,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    value.first.email,
                                    style: TextStyle(fontSize: 8.sp),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(vertical: 0.8.h)),
                                side:
                                    MaterialStateProperty.all(BorderSide.none),
                                backgroundColor:
                                    MaterialStateProperty.all(buttoncolor[300]),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                        profileid: profileData.value.first),
                                  ),
                                );
                              },
                              child: Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      const ListTileDrawer(
                        so: 1,
                        map: Favorite(),
                        imagedata: 'assets/UI/icons/favorite.png',
                        textdata: 'Favorite',
                      ),
                      SizedBox(height: 1.h),
                      ListTileDrawer(
                        so: 1,
                        map: Reset(profileid: profileid),
                        imagedata: 'assets/UI/icons/Sales.png',
                        textdata: 'Transaction history',
                      ),
                      SizedBox(height: 1.h),
                      const ListTileDrawer(
                        so: 1,
                        map: AppInfo(),
                        imagedata: 'assets/UI/icons/about us.png',
                        textdata: 'App info',
                      ),
                      SizedBox(height: 1.h),
                      const ListTileDrawerEmail(),
                      SizedBox(height: 1.h),
                      const ListTileDrawer(
                        so: 2,
                        imagedata: 'assets/UI/icons/privacy.png',
                        textdata: 'Privacy',
                      ),
                      SizedBox(height: 1.h),
                      const ListTileDrawer(
                        so: 3,
                        imagedata: 'assets/UI/icons/terms of service.png',
                        textdata: 'Terms of Service',
                      ),
                      SizedBox(height: 1.h),
                      ListTileDrawer(
                        so: 1,
                        map: Reset(profileid: profileid),
                        imagedata: 'assets/UI/icons/backup.png',
                        textdata: 'Reset Data',
                      ),
                      SizedBox(height: 1.h),
                      const ListTileDrawer(
                        so: 4,
                        imagedata: 'assets/UI/icons/logout.png',
                        textdata: 'Logout',
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
