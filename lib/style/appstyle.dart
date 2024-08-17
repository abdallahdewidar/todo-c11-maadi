import 'package:flutter/material.dart';

class Appstyle{
  static Color lightPrimaryColor = Color(0xff5D9CEC);
  static Color lightTextColor = Color(0xff383838);
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xffDFECDB),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightPrimaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 3
        )
      )
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: Colors.white
      ),
      backgroundColor: lightPrimaryColor,
      toolbarHeight: 110,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 22
      )
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: lightPrimaryColor,primary: lightPrimaryColor),
    useMaterial3: false,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: lightPrimaryColor
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 20
      )
    )
  );
}