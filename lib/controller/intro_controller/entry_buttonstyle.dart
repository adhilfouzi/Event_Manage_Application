import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ButtonStyle withr = ButtonStyle(
  padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.5.h)),
  side: WidgetStateProperty.all(BorderSide(color: Colors.white, width: 0.3.h)),
  backgroundColor: WidgetStateProperty.all(Colors.transparent),
  shape: WidgetStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  )),
);
