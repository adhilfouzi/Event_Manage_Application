import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ButtonStyle withr = ButtonStyle(
  padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.5.h)),
  side:
      MaterialStateProperty.all(BorderSide(color: Colors.white, width: 0.3.h)),
  backgroundColor: MaterialStateProperty.all(Colors.transparent),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  )),
);
