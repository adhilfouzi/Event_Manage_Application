import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Event Manager',
          style: TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold),
        ),
        Image.asset('assets/UI/Event Logo/event logo top.png'),
        Padding(
            padding: EdgeInsets.all(2.h), child: const Text('Version 1.00.0')),
      ]),
    );
  }
}
