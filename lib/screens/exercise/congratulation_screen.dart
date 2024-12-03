import 'package:fitnesapp/models/daily_progress.dart';
import 'package:fitnesapp/utils/app_constants.dart';
import 'package:fitnesapp/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/utils/formatters.dart';
import 'package:fitnesapp/screens/progress/daily_progress_screen.dart'; // Add this import

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({
    super.key,
    required this.progress,
  });

  final DailyProgress progress;

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Trophy Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset(
              'asset/image/Trophy.png', // Replace with your trophy image path
            ),
          ),
          const SizedBox(height: 20),
          // Title
          Container(
            decoration: const BoxDecoration(
              color: AppConstants.yellow,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  const Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Workout Summary Row
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _infoCard(
                              capitalizeFirstLetter(
                                  widget.progress.bodyPart.toString()),
                              Icons.directions_run),
                          _infoCard(
                              "${widget.progress.doneExercise}/${widget.progress.totalExercise} Exercises",
                              Icons.local_fire_department),
                          _infoCard(
                              "${widget.progress.progressPercentage}% Done",
                              Icons.pie_chart_sharp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
          // Buttons
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: GradientButton(
          //       text: "Go to the next workout",
          //       onPressed: () {
          //         // Handle navigation to the next workout
          //         Navigator.popUntil(context, ModalRoute.withName('/'));
          //       }),
          // ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DailyProgressScreen(),
                ),
              ); // Handle navigation to Home
            },
            child: const Text(
              'Go to Progress',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
              backgroundColor: AppConstants.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              Navigator.popUntil(context,
                  ModalRoute.withName('/')); // Handle navigation to Home
            },
            child: const Text(
              'Home',
              style:
                  TextStyle(fontSize: 16.0, color: AppConstants.secondaryColor),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _infoCard(String text, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          child: Icon(icon, color: const Color.fromARGB(255, 18, 18, 18)),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
              fontSize: 14.0, color: Color.fromARGB(255, 105, 105, 105)),
        ),
      ],
    );
  }
}
