import 'package:flutter/material.dart';
import 'package:fitnesapp/widgets/card_body.dart'; // Adjust the import path as necessary
import 'package:fitnesapp/utils/app_constants.dart'; // Adjust the import path as necessary

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
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
