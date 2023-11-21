import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:sizer/sizer.dart';

class TextFieldBlue extends StatelessWidget {
  final String textcontent;
  final String? Function(String?)? validator;
  final IconData? preicondata;
  final IconData? posticondata;
  final TextEditingController? controller;
  final TextInputType? keyType;
  final bool? obscureText;
  final bool? enabled;
  final void Function(String)? onChanged;

  const TextFieldBlue(
      {super.key,
      required this.textcontent,
      this.preicondata,
      this.posticondata,
      this.controller,
      this.validator,
      this.keyType,
      this.obscureText,
      this.enabled,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 2.h),
          child: Text(textcontent, style: raleway(fontSize: 2.2.h)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
          child: TextFormField(
            enabled: enabled == null ? true : false,
            obscureText: obscureText == null ? false : true,
            keyboardType: keyType,
            validator: validator,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 0.3.h,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: buttoncolor,
                  width: 0.2.h,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: buttoncolor,
                  width: 0.2.h,
                ),
              ),
              iconColor: buttoncolor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 1.h,
                vertical: 1.h,
              ),
              prefixIcon: preicondata != null
                  ? Icon(preicondata, size: 4.h, color: buttoncolor[700])
                  : null,
              suffixIcon: posticondata != null
                  ? Icon(posticondata, size: 4.h, color: buttoncolor[700])
                  : null,
              hintText: textcontent,
              hintStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  fontFamily: 'Raleway',
                  fontSize: 1.8.h),
            ),
          ),
        ),
      ],
    );
  }
}
