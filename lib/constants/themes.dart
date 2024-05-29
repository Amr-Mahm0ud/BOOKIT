import 'package:flutter/material.dart';

const Color lightPrimary = Color(0xff4196e0);
const Color lightSecondaryClr = Color(0xff32769b);
const Color backLight = Color(0xFFf5f5f5);
const Color lightGrayShade = Color(0xFFf5f4f1);
const Color lightText = Color(0xFF2c2c2c);

const Color darkPrimary = Color(0xff4196e0);
const Color darkSecondaryClr = Color(0xff32769b);
const Color backDark = Color(0xFF1A1A1A);
const Color darkGrayShade = Color(0xFF292929);
const Color darkText = Color(0xFFe0e0e0);

class Themes {
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: lightPrimary,
    splashColor: lightPrimary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: backLight,
    cardColor: lightGrayShade,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: lightText,
      backgroundColor: backLight,
    ),
    textTheme: ThemeData.light().textTheme.apply(displayColor: lightText),
    cardTheme: ThemeData.light().cardTheme.copyWith(color: lightGrayShade),
    colorScheme: const ColorScheme.light()
        .copyWith(
          primary: lightPrimary,
          secondary: lightSecondaryClr,
          error: Colors.redAccent,
        )
        .copyWith(background: backLight),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: darkPrimary,
    splashColor: darkPrimary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backDark,
    cardColor: darkGrayShade,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: darkText,
      backgroundColor: backDark,
    ),
    textTheme: ThemeData.dark().textTheme.apply(displayColor: darkText),
    cardTheme: ThemeData.light().cardTheme.copyWith(color: darkGrayShade),
    colorScheme: const ColorScheme.dark()
        .copyWith(
          primary: darkPrimary,
          secondary: darkSecondaryClr,
          error: Colors.redAccent,
        )
        .copyWith(background: backDark),
  );
}
