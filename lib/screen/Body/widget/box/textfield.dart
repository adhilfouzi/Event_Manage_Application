import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
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
      margin: EdgeInsets.symmetric(
          vertical: 0.5.h, horizontal: 2.h), // Adjust the margin.
      decoration: BoxDecoration(
        color: Colors.black12, // Set your desired background color.
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.symmetric(
          //     horizontal: 0.5.h, vertical: 0.5.h), // Adjust vertical padding.
          prefixIcon: Icon(icondata, size: 4.h), // Increase the icon size.
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
