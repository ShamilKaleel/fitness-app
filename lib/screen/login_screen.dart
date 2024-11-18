import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/screen/signup_screen.dart';
import 'package:fitnesapp/screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppConstants.bgcColor,
      appBar: AppBar(
        backgroundColor: AppConstants.bgcColor,
        elevation: 0,
        centerTitle: true, // Centers the title
        title: Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppConstants.yellow,
            fontSize: screenHeight * 0.035,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: screenHeight * 0.035,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.yellow,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.02,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Container(
                width: screenWidth,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppConstants.purple,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.1,
                    right: screenWidth * 0.1,
                    top: screenHeight * 0.02,
                  ),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.white.withOpacity(0.2), // Transparent background
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent, // No shadow
                  side: const BorderSide(
                      color: Colors.white, width: 1), // White outline
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(screenWidth * 0.7, 50),
                ),
                child: const Text('Log In'),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
