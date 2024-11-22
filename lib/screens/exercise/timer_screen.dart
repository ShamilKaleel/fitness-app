import 'package:flutter/material.dart';
import '../../models/exercise.dart';
import 'exercise_start_screen.dart';

class TimerScreen extends StatefulWidget {
  final List<Exercise> exercises;

  const TimerScreen({required this.exercises, super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int remainingSeconds = 10;

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
              Color(0xFF0073FE), // Top-left color
              Color(0xFF0054FF), // Bottom-right color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Starting in $remainingSeconds seconds...',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: skipTimer,
                  child: const Text('Skip Timer'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: cancelWorkout,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 45, 35, 236)),
                  child: const Text('Cancel Workout',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
