import 'package:fitnesapp/screens/home_screen.dart';
import 'package:fitnesapp/screens/main_screen.dart';
import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/screens/auth/onboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnesapp/screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark, // Set the default theme mode to dark
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xFF007E85), // Custom primary color
      colorScheme: ColorScheme.dark(
        secondary: Colors.tealAccent,
      ),
      scaffoldBackgroundColor: AppConstants.bgcColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppConstants.bgcColor,
        iconTheme: IconThemeData(color: AppConstants.yellow),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFF007E85), // Custom button color
        textTheme: ButtonTextTheme.primary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppConstants.purple, // Background color
        selectedItemColor: Colors.tealAccent, // Selected item color
        unselectedItemColor: Colors.white70, // Unselected item color
      ),
    ),
    home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data != null) {
          return const MainScreen();
        }
        return const OnboardScreen();
      },
    ),
  ));
}
