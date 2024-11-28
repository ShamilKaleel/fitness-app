import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/screens/home_screen.dart';
import 'package:fitnesapp/screens/nutrition/nutrition_screen.dart';
import 'package:fitnesapp/screens/bmi/bmi_screen.dart';
import 'package:fitnesapp/screens/profile/profile_screen.dart';
import 'package:fitnesapp/screens/progress/progress_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    HomeScreen(), // Just the content for the home tab
    NutritionScreen(),
    ProgressScreen(),
    BMIScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Track selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        elevation: 0, // Remove the shadow
        // Background color
        selectedItemColor: const Color.fromARGB(
            255, 255, 255, 255), // Color for the selected label and icon
        unselectedItemColor:
            Colors.grey, // Color for the unselected labels and icons
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_rounded),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center,
            ),
            label: 'BMI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
