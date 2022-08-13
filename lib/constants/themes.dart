import 'package:flutter/material.dart';

const Color primaryClr = Color(0xff2DA8FF);
const Color secondaryClr = Color(0xffB06AB3);
const Color backLight = Color(0xFFF5F5F5);
const Color backDark = Color(0xFF000000);
const Color grayShade = Color(0xFF323232);
const Color white = Color(0xFFFFFFFF);

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryClr,
    backgroundColor: backLight,
    splashColor: primaryClr,
    brightness: Brightness.light,
    scaffoldBackgroundColor: backLight,
    cardColor: white,
    appBarTheme: const AppBarTheme(
        elevation: 0, foregroundColor: backDark, color: backLight),
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryClr,
      secondary: secondaryClr,
      error: Colors.redAccent,
    ),
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Nunito'),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryClr,
    backgroundColor: backDark,
    splashColor: primaryClr,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backDark,
    cardColor: grayShade,
    appBarTheme: const AppBarTheme(
        elevation: 0, foregroundColor: white, color: backDark),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryClr,
      secondary: secondaryClr,
      error: Colors.redAccent,
    ),
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Nunito'),
  );
}
