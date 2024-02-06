import 'package:flutter/material.dart';
import 'package:project_event/model/core/color/color.dart';

TextStyle readexPro({
  Color color = Colors.black,
  double fontSize = 16,
  String fontFamily = 'ReadexPro',
  FontWeight fontWeight = FontWeight.bold,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
  );
}

TextStyle racingSansOne({
  Color color = Colors.white,
  String fontFamily = 'RacingSansOne',
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return TextStyle(
    color: color,
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle raleway({
  Color color = buttoncolor,
  String fontFamily = 'Raleway',
  double fontSize = 18,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return TextStyle(
    color: color,
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}
