import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

class Contact extends StatelessWidget {
  final TextEditingController? pcontroller;
  final TextEditingController? econtroller;
  final TextEditingController? acontroller;

  const Contact(
      {super.key, this.pcontroller, this.econtroller, this.acontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
        decoration: BoxDecoration(
          border: Border.all(color: buttoncolor, width: 1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(children: [
          Text(
            'Contact Details',
            style: raleway(),
          ),
          const Divider(
            color: buttoncolor,
            height: 20,
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
