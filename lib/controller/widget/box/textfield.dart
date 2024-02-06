import 'package:flutter/material.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:sizer/sizer.dart';

class TextFieldicon extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icondata;
  final String textcontent;
  final void Function(String)? onChanged;

  const TextFieldicon({
    super.key,
    required this.controller,
    this.icondata,
    required this.textcontent,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.5.h),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.black12,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 0.8.h, vertical: 0.8.h),
          prefixIcon: Icon(icondata, size: 4.h),
          hintText: textcontent,
          hintStyle: raleway(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
