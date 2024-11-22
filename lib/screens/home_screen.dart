import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/screens/exercise/exercise_screen.dart';
import 'package:fitnesapp/services/firebase_auth_service.dart'; // Add this line to import the FirebaseAuthService

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> bodyParts = AppConstants.bodyParts;
  final authService = FirebaseAuthService();

  // List of screens for navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Body Part'),
        actions: [
          IconButton(
              icon: const Icon(Icons.person, color: Color(0xFF896CFE)),
              onPressed: () async {
                await authService.signOut();
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: bodyParts.length,
        itemBuilder: (context, index) {
          final bodyPart = bodyParts[index];
          return ListTile(
            title: Text(
              bodyPart[0].toUpperCase() + bodyPart.substring(1),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(bodyPart: bodyPart),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
