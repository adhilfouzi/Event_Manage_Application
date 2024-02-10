import 'package:flutter/material.dart';
import 'package:project_event/controller/services/textvalidator.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:sizer/sizer.dart';

class ContactState extends StatelessWidget {
  final TextEditingController? pcontroller;
  final TextEditingController? econtroller;
  final TextEditingController? acontroller;

  const ContactState({
    super.key,
    this.pcontroller,
    this.econtroller,
    this.acontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.h),
      child: Container(
        padding: EdgeInsets.fromLTRB(0.5.h, 1.h, 0.5.h, 2.h),
        decoration: BoxDecoration(
          border: Border.all(color: buttoncolor, width: 2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(children: [
          Text(
            'Contact Details',
            style: raleway(),
          ),
          Divider(
            color: buttoncolor,
            height: 2.h,
            thickness: 2,
            endIndent: 40,
            indent: 40,
          ),
          TextValidator()
              .phoneNumber(phoneController: pcontroller!, bool: true),
          TextValidator().emailTextField(econtroller!, bool: true),
          TextValidator()
              .place(controller: acontroller!, textcontent: 'Address'),
        ]),
      ),
    );
  }
}
