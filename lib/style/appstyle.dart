import 'package:flutter/material.dart';

class Appstyle {
  // Light theme colors
  static Color lightPrimaryColor = Color(0xff5D9CEC); // Light blue primary color
  static Color lightAccentColor = Color(0xff4CAF50); // Green for accent
  static Color lightBackgroundColor = Color(0xffF1F5F9); // Light grey background
  static Color lightCardColor = Color(0xffFFFFFF); // Pure white for cards/containers
  static Color lightTextColor = Color(0xff383838); // Dark grey for text

  // Dark theme colors
  static Color darkPrimaryColor = Color(0xff64B5F6); // Slightly lighter blue for dark mode
  static Color darkBackgroundColor = Color(0xff1A1A1A); // Dark grayish background
  static Color darkCardColor = Color(0xff2E2E2E); // Lighter dark color for cards and containers
  static Color darkTextColor = Color(0xffE0E0E0); // Light gray for text in dark mode
  static Color darkAccentColor = Color(0xffBB86FC); // Accent color for highlights (purple)

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackgroundColor, // Softer background color
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightAccentColor, // Accent color for floating button
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: lightPrimaryColor,
      toolbarHeight: 110,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
    ),
    cardColor: lightCardColor, // Consistent white background for cards
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightPrimaryColor,
      primary: lightPrimaryColor,
      secondary: lightAccentColor, // Use accent color for buttons/highlights
    ),
    useMaterial3: false,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: lightPrimaryColor, // Primary color for headers
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: lightTextColor, // Darker text color for readability
        fontSize: 16,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkPrimaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.grey[800]!,
          width: 3,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: darkTextColor,
      ),
      backgroundColor: darkPrimaryColor,
      toolbarHeight: 110,
      titleTextStyle: TextStyle(
        color: darkTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkPrimaryColor,
      primary: darkPrimaryColor,
      secondary: darkAccentColor, // Using the accent color for highlights
      brightness: Brightness.dark,
    ),
    useMaterial3: false,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darkTextColor,
      ),
      labelLarge: TextStyle(
        color: darkTextColor,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: darkTextColor,
        fontSize: 16,
      ),
    ),
  );
}
