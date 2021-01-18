import 'package:flutter/material.dart';
import 'package:hope_clinic/utils/color.dart';
final Color primaryColor = HexColor("#077965");
final Color primaryColorDark = HexColor("#000000");
final Color customGreen = HexColor("#0AC690");
final Color accentColor = HexColor("#D7F4EF");
final Color containerBgColor = HexColor("#EEEEEE");
final Color textColor = HexColor("#666666");
final Color hintColor = HexColor("#C4C4C4");

ThemeData appTheme = new ThemeData(
  textSelectionHandleColor: Colors.orange,
  primaryColor: primaryColor,
  primaryColorDark: primaryColorDark,
  fontFamily: "Lato",
  primarySwatch: MaterialColor(
    HexColor.getColorFromHex("#09125D"),
    primarySwatch,
  ),
  // canvasColor: Colors.transparent,
);

TextStyle onboardingInfoTextStyle = TextStyle(
  fontSize: 14.5,
  letterSpacing: 0.2,
  fontWeight: FontWeight.w400,
  fontFamily: 'Lato',
  color: HexColor("#808080"),
);
TextStyle inputTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  color: HexColor('#222121'),
);
TextStyle subheadingTextStyle = TextStyle(
    color: Colors.redAccent,
    fontFamily: 'Lato',
    fontSize: 14.0,
    fontWeight: FontWeight.w400);
Map<int, Color> primarySwatch = {
  50: Color.fromRGBO(9, 18, 93, .1),
  100: Color.fromRGBO(9, 18, 93, .2),
  200: Color.fromRGBO(9, 18, 93, .3),
  300: Color.fromRGBO(9, 18, 93, .4),
  400: Color.fromRGBO(9, 18, 93, .5),
  500: Color.fromRGBO(9, 18, 93, .6),
  600: Color.fromRGBO(9, 18, 93, .7),
  700: Color.fromRGBO(9, 18, 93, .8),
  800: Color.fromRGBO(9, 18, 93, .9),
  900: Color.fromRGBO(9, 18, 93, 1),
};