import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/Screen/profile/privacy.dart';
import 'package:project_event/screen/intro/loginpage.dart';

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
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('LogOut Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}
