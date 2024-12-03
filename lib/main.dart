import 'package:fitnesapp/screens/main_screen.dart';
import 'package:fitnesapp/theme/app_theme.dart';
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
    darkTheme: AppTheme.darkTheme,
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
        return const LoginScreen();
      },
    ),
  ));
}
