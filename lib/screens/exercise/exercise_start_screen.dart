import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import '../../models/exercise.dart';
import 'exercise_screen.dart';
import 'congratulation_screen.dart';

class ExerciseStartScreen extends StatefulWidget {
  final List<Exercise> exercises;

  const ExerciseStartScreen({required this.exercises, super.key});

  @override
  _ExerciseStartScreenState createState() => _ExerciseStartScreenState();
}

class _ExerciseStartScreenState extends State<ExerciseStartScreen> {
  int currentExerciseIndex = 0;
  int remainingSeconds = 30;
  bool isRestPeriod = false;

  late Exercise currentExercise;

  @override
  void initState() {
    super.initState();
    currentExercise = widget.exercises[currentExerciseIndex];
  }

  void goToNextExercise() {
    // Start the rest period if it's not already rest time
    if (!isRestPeriod) {
      setState(() {
        isRestPeriod = true;
        remainingSeconds = 30; // Set rest time to 30 seconds
      });
      startRestTimer();
    } else {
      // If we are in the rest period, go to the next exercise after rest

      if (currentExerciseIndex < widget.exercises.length - 1) {
        setState(() {
          currentExerciseIndex++;
          currentExercise = widget.exercises[currentExerciseIndex];
          isRestPeriod = false;
        });
      } else {
        // End of exercises, navigate to the congratulation screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CongratulationScreen()),
        );
      }
    }
  }

  void startRestTimer() {
    // Start the 30-second rest period
    Future.delayed(const Duration(seconds: 1), () {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
        startRestTimer(); // Continue the countdown
      }
    });
  }

  void cancelExercise() {
    // Go back to the ExerciseScreen when the user wants to cancel
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CongratulationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Exercise ${currentExerciseIndex + 1}'),
            const SizedBox(width: 10),
            Text('of ${widget.exercises.length}'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isRestPeriod)
              Column(
                children: [
                  Image.network(
                    currentExercise.gifUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentExercise.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "X10",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 75,
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rest Time: $remainingSeconds seconds',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: cancelExercise,
              child: const Text('Cancel and Go Back'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: goToNextExercise,
              child: const Text('Next Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}
