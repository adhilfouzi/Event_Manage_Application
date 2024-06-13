import 'package:flutter/material.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:sizer/sizer.dart';

ButtonStyle firstbutton() {
  return ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    side: WidgetStateProperty.all(BorderSide.none),
    backgroundColor: WidgetStateProperty.all(buttoncolor),
  );
}

ButtonStyle secbutton() {
  return ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )),
  );
}
