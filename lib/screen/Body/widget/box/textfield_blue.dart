import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final List<TextInputFormatter>? inputFormatters;

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
      this.onChanged,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 2.h),
          child: Text(textcontent, style: raleway(fontSize: 13.sp)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 0.2.h),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: inputFormatters,
            enabled: enabled == null ? true : false,
            obscureText: obscureText == null ? false : true,
            keyboardType: keyType,
            validator: validator,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 0.4.w,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 0.4.w,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: BorderSide(
                  color: graylight,
                  width: 0.4.w,
                ),
              ),
              iconColor: graylight,
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
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  fontFamily: 'Raleway',
                  fontSize: 11.sp),
            ),
          ),
        ),
      ],
    );
  }
}
