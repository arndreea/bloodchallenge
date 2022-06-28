import 'dart:ui';

import 'package:flutter/material.dart';

class Style {
  //fonts
  static const String poppinsFont = 'Poppins';
  static const String poppinsBoldFont = 'Poppins-Bold';
  static const String poppinsLightFont = 'Poppins-Light';
  static const String poppinsMediumFont = 'Poppins-Medium';
  static const int defaultErrorMaxLines = 1;

  static TextStyle poppinsRegularTextStyleWith(
      {double? fontSize,
      Color? color,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: poppinsFont,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.purple,
        fontStyle: fontStyle,
        decoration: decoration);
  }

  static TextStyle poppinsBoldTextStyleWith(
      {double? fontSize, Color? color, TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: poppinsBoldFont,
        fontSize: fontSize,
        color: color ?? Colors.purple,
        decoration: decoration);
  }
}
