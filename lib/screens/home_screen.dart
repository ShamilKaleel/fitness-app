import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/services/firebase_auth_service.dart';
import 'package:fitnesapp/widgets/card_body.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> bodyParts = AppConstants.bodyParts;
  final authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workouts', style: TextStyle(), textAlign: TextAlign.left),
            Text(
              'Choose a body part to get started!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.person, color: Color(0xFF896CFE)),
              onPressed: () async {
                await authService.signOut();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: ListView.builder(
          itemCount: AppConstants.bodyPartsImage.length,
          itemBuilder: (context, index) {
            return CardBody(
              bodyPart: (AppConstants.bodyPartsImage[index]['name'] as String),
              imageURL: AppConstants.bodyPartsImage[index]['image'] as String,
            );
          },
        ),
      ),
    );
  }
}
