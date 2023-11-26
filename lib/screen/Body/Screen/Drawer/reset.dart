import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/Screen/main/home_screen.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
import 'package:project_event/screen/intro/loginpage.dart';
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
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MainBottom(profileid: widget.profileid),
                            ),
                            (route) => false,
                          );
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
