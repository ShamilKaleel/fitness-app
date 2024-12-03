import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import '../../models/exercise.dart';
import 'exercise_start_screen.dart';

class TimerScreen extends StatefulWidget {
  final List<Exercise> exercises;

  const TimerScreen({required this.exercises, super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int remainingSeconds = 2000;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
        startTimer();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ExerciseStartScreen(exercises: widget.exercises),
          ),
        );
      }
    });
  }

  void skipTimer() {
    setState(() {
      remainingSeconds = 0;
    });
  }

  void cancelWorkout() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstants.purple, // Top-left color
              AppConstants.secondaryColor, // Bottom-right color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "READY TO GO",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ' $remainingSeconds ',
                    style: const TextStyle(
                        fontSize: 130,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Exercises: 1/${widget.exercises.length}',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ' ${widget.exercises[0].name.toUpperCase()} ',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: skipTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Start!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 50,
                left: 5,
                child: TextButton(
                  onPressed: cancelWorkout,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  child: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
