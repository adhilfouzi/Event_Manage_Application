import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/main.dart';
import 'package:project_event/view/intro_screen/loginpage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
