import 'package:flutter/material.dart';
import 'package:fitnesapp/utils/app_constants.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppConstants.yellow,
            fontSize: screenHeight * 0.025,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppConstants.yellow,
            size: AppConstants.bodyFontSize,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
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
                      SizedBox(height: screenHeight * 0.02),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Confrom password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: () {},
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
                child: const Text('Sign Up'),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Already have an account? Log In",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
