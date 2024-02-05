import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/main.dart';
import 'package:project_event/screen/body/screen/profile/privacy.dart';
import 'package:project_event/screen/intro/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListTileDrawer extends StatelessWidget {
  final int so;
  final Widget? map;
  final String imagedata;
  final String textdata;
  const ListTileDrawer(
      {super.key,
      required this.imagedata,
      required this.textdata,
      this.map,
      required this.so});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imagedata),
      title: Text(
        textdata,
        style: readexPro(),
      ),
      onTap: () {
        if (so == 1) {
          Get.to(transition: Transition.rightToLeftWithFade, map!);
        } else if (so == 2) {
          launchPrivacyPolicy();
        } else if (so == 3) {
          launchTerms();
        } else if (so == 4) {
          confirmLogout(context);
        }
      },
    );
  }
}

Future<void> confirmLogout(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Get.offAll(
                  transition: Transition.rightToLeftWithFade,
                  //     allowSnapshotting: false,
                  fullscreenDialog: true,
                  const LoginScreen());

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('LogOut Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              final sharedPrefer = await SharedPreferences.getInstance();
              await sharedPrefer.remove(logedinsp);
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}
