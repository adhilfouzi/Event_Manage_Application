import 'package:flutter/material.dart';
import 'package:project_event/core/color/color.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/screen/body/widget/box/textfield_blue.dart';
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
            validator: (value) {
              if (value!.isNotEmpty) {
                final phoneNumberWithoutSpaces = value.replaceAll(' ', '');

                if (phoneNumberWithoutSpaces.startsWith('+') &&
                    phoneNumberWithoutSpaces.length >= 13) {
                  return null;
                } else if (!phoneNumberWithoutSpaces.startsWith('+') &&
                    phoneNumberWithoutSpaces.length == 10) {
                  return null;
                } else {
                  return 'Enter a valid phone number';
                }
              }
              return null;
            },
            keyType: TextInputType.phone,
            controller: pcontroller,
            textcontent: 'Phone Number',
            posticondata: Icons.call,
          ),
          TextFieldBlue(
            validator: (value) {
              if (value!.isNotEmpty) {
                if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(value)) {
                  return 'Enter a valid email address';
                }
              }
              return null;
            },
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
