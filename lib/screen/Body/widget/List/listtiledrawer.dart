import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/Screen/Drawer/privacy.dart';

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
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => map!));
        } else if (so == 2) {
          launchPrivacyPolicy();
        } else if (so == 3) {
          launchTerms();
        }
      },
    );
  }
}
