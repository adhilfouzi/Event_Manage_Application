import 'package:flutter/material.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:sizer/sizer.dart';

ButtonStyle firstbutton() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    side: MaterialStateProperty.all(BorderSide.none),
    backgroundColor: MaterialStateProperty.all(buttoncolor),
  );
}

ButtonStyle secbutton() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1.h)),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )),
  );
}
