import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fitnesapp/screens/exercise/exercise_screen.dart';

class CardBody extends StatelessWidget {
  final String bodyPart;

  final String imageURL;

  const CardBody({super.key, required this.bodyPart, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExerciseScreen(bodyPart: bodyPart)),
        );
      },
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
          color: AppConstants.bgcColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppConstants.secondaryColor, // Left color
                    AppConstants.purple, // Right color
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                  color: const Color(0xFFE2F163),
                  width: 1,
                )),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bodyPart.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFE2F163),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Text(
                        "10 Workout Schedule",
                        style: TextStyle(
                            color: Color.fromARGB(179, 255, 255, 255)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imageURL, // Replace with your asset image path
                    height: 170,
                    width: 155,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
