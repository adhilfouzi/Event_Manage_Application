import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
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
          TextFieldBlue(
            keyType: TextInputType.phone,
            controller: pcontroller,
            textcontent: 'Phone Number',
            posticondata: Icons.call,
          ),
          TextFieldBlue(
            keyType: TextInputType.emailAddress,
            controller: econtroller,
            textcontent: 'Email Id',
            posticondata: Icons.mail,
          ),
          TextFieldBlue(
            keyType: TextInputType.streetAddress,
            controller: acontroller,
            textcontent: 'Address',
            posticondata: Icons.location_on,
          )
        ]),
      ),
    );
  }
}
