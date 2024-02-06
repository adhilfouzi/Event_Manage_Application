import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/view/body_screen/main/home_screen.dart';
import 'package:project_event/view/body_screen/main/main_screem.dart';
import 'package:project_event/view/intro_screen/loginpage_screen.dart';
import 'package:sizer/sizer.dart';

class Reset extends StatefulWidget {
  final int profileid;

  const Reset({super.key, required this.profileid});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.h),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text('RESET DATA ', style: readexPro(fontSize: 20.sp)),
          //Text('Clear all Data from this application'),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: checkboxValue,
                    onChanged: (bool? value) {
                      setState(() {
                        checkboxValue = value!;
                      });
                    },
                  ),
                  const Text(
                    'Clear all Data from this application ',
                    style: TextStyle(color: buttoncolor),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: firstbutton(),
                      onPressed: () {
                        if (checkboxValue == true) {
                          clearDb();
                          Get.offAll(
                              transition: Transition.leftToRightWithFade,
                              //     allowSnapshotting: false,
                              fullscreenDialog: true,
                              MainBottom(profileid: widget.profileid));
                        } else {
                          return;
                        }
                      },
                      child: Text('Clear Data',
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
