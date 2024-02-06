import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/main/fn_confirm_logout.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/view/body_screen/profile/privacy_function_screen.dart';

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
