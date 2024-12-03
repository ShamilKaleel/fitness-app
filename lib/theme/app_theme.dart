import 'package:flutter/material.dart';
import 'package:fitnesapp/utils/app_constants.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppConstants.bgcColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppConstants.bgcColor, // Background color
      iconTheme: IconThemeData(color: AppConstants.yellow),
      elevation: 0, // Shadow elevation
      titleTextStyle: TextStyle(
        color: AppConstants.secondaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppConstants.purple, // Background color
      selectedItemColor: Colors.white, // Selected item color
      unselectedItemColor: Colors.grey, // Unselected item color
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppConstants.yellow, // Background color
      contentTextStyle: const TextStyle(
        color: Colors.black, // Text color
        fontSize: 16,
      ),
      actionTextColor: AppConstants.yellow, // Action button text color
      behavior: SnackBarBehavior.floating, // Floating behavior
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      elevation: 8,
    ),
  );
}
