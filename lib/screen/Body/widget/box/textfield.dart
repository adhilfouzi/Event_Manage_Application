import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';

class TextFieldicon extends StatelessWidget {
  final TextEditingController controller;
  final IconData icondata;
  final String textcontent;

  const TextFieldicon({
    super.key,
    required this.controller,
    required this.icondata,
    required this.textcontent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 5, horizontal: 16), // Adjust the margin.
      decoration: BoxDecoration(
        color: Colors.white, // Set your desired background color.
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 10), // Adjust vertical padding.
          prefixIcon: Icon(icondata, size: 24), // Increase the icon size.
          hintText: textcontent,
          hintStyle: raleway(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
