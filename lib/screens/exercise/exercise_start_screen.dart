import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnesapp/models/daily_progress.dart';
import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import '../../models/exercise.dart';
import 'congratulation_screen.dart';
import 'package:fitnesapp/widgets/exercise_progress_bar.dart';
import 'dart:async';
import 'package:fitnesapp/services/daily_progress_service.dart';

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
  bool _isLorading = false;

  late Exercise currentExercise;
  late DailyProgress _dailyProgress;

  Timer? restTimer; // Add a Timer object to manage the countdown
  final _service = DailyProgressService();
  @override
  void initState() {
    super.initState();
    currentExercise = widget.exercises[currentExerciseIndex];
  }

  void goToNextExercise() {
    if (restTimer != null) {
      restTimer!.cancel(); // Cancel any active timers before proceeding
    }
    // Start the rest period if it's not already rest time
    if (!isRestPeriod) {
      setState(() {
        isRestPeriod = true;
        remainingSeconds = 30; // Set rest time to 30 seconds
      });
      startRestTimer();
    } else {
      // If we are in the rest period, go to the next exercise after rest
      if (currentExerciseIndex == widget.exercises.length - 1) {
        cancelExercise();
      }
      if (currentExerciseIndex < widget.exercises.length - 1) {
        setState(() {
          currentExerciseIndex++;
          currentExercise = widget.exercises[currentExerciseIndex];
          isRestPeriod = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    restTimer?.cancel();
    super.dispose();
  }

  void startRestTimer() {
    // Ensure no overlapping timers
    restTimer?.cancel();

    // Start the 30-second rest period
    restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
        startRestTimer(); // Continue the countdown
      } else {
        timer.cancel();
        goToNextExercise();
      }
    });

    // if (remainingSeconds == 0 &&
    //     currentExerciseIndex < widget.exercises.length - 1) {
    //   goToNextExercise();
    // }
  }

  void cancelExercise() async {
    if (restTimer != null) {
      restTimer!.cancel();
    }
    if (currentExerciseIndex == 0) {
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      try {
        _dailyProgress = DailyProgress(
          id: DateTime.now().millisecondsSinceEpoch,
          doneExercise: currentExerciseIndex,
          totalExercise: widget.exercises.length,
          date: DateTime.now(),
          userId: FirebaseAuth.instance.currentUser!.uid,
          bodyPart: widget.exercises[0].bodyPart,
        );

        setState(() {
          _isLorading = true;
        });

        await _service.addDailyProgress(_dailyProgress); // Save the progress

        setState(() {
          _isLorading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CongratulationsScreen(
              progress: _dailyProgress,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
      // Go back to the ExerciseScreen when the user wants to cancel
    }
  }

  void goToPreviousExercise() {
    // Go back to the Exercise when the user wants to go back
    setState(() {
      currentExerciseIndex--;
      currentExercise = widget.exercises[currentExerciseIndex];
    });
  }

  void skipExercise() {
    // Cancel the current timer before skipping
    if (restTimer != null) {
      restTimer!.cancel();
    }
    if (currentExerciseIndex == widget.exercises.length - 1) {
      cancelExercise();
    }
    if (currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        currentExercise = widget.exercises[currentExerciseIndex];
        isRestPeriod = false; // Skip directly to the next exercise
      });
    }
  }

  void addTime() {
    // Add 20 seconds to the rest period
    setState(() {
      remainingSeconds += 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _isLorading
            ? const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      !isRestPeriod
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(
                              255, 123, 96, 234), // Top-left color
                      !isRestPeriod
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(
                              255, 87, 49, 235), // Bottom-right color
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      !isRestPeriod
                          ? Column(
                              children: [
                                const SizedBox(height: 13),
                                ExerciseProgressBar(
                                  scheduleSize: widget.exercises.length,
                                  doneCount: currentExerciseIndex,
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: cancelExercise,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.transparent),
                                        child: const Icon(Icons.close,
                                            color:
                                                Color.fromARGB(255, 49, 49, 49),
                                            size: 30),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(height: 10),
                                          Text(
                                            currentExerciseIndex + 1 <
                                                    widget.exercises.length
                                                ? widget
                                                            .exercises[
                                                                currentExerciseIndex +
                                                                    1]
                                                            .name
                                                            .length >
                                                        30
                                                    ? '${widget.exercises[currentExerciseIndex + 1].name.substring(0, 30).toUpperCase()}...'
                                                    : widget
                                                        .exercises[
                                                            currentExerciseIndex +
                                                                1]
                                                        .name
                                                        .toUpperCase()
                                                : 'No more exercises',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.end,
                                          ),
                                          const Text(
                                            'Next',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(width: 10),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.network(
                                        currentExercise.gifUrl,
                                        width: double.infinity,
                                        height: 400,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 50),
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
                                      "x10",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 75,
                                          color: AppConstants.secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 80),
                                    // Add a row for the "Start" and "Next" buttons
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Spacer(),
                                          currentExerciseIndex == 0
                                              ? IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.arrow_back,
                                                    color: Colors.transparent,
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Colors.grey[300]!,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40), // Rounded border
                                                  ),
                                                  child: IconButton(
                                                    onPressed:
                                                        goToPreviousExercise,
                                                    icon: const Icon(
                                                      Icons.skip_previous,
                                                      color: Colors.black,
                                                      size: 40,
                                                    ),
                                                    tooltip: 'Go to Previous',
                                                  ),
                                                ),
                                          const Spacer(),
                                          // Push the "Done" button to the center
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  AppConstants
                                                      .purple, // Left color
                                                  Color.fromARGB(255, 100, 75,
                                                      197), // Right color
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: TextButton(
                                              onPressed: currentExerciseIndex ==
                                                      widget.exercises.length -
                                                          1
                                                  ? cancelExercise
                                                  : goToNextExercise,
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          // Push the "Done" button to the center
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[300]!,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      40), // Rounded border
                                            ),
                                            child: IconButton(
                                              onPressed: currentExerciseIndex ==
                                                      widget.exercises.length -
                                                          1
                                                  ? cancelExercise
                                                  : goToNextExercise,
                                              icon: const Icon(
                                                Icons.skip_next,
                                                color: Colors.black,
                                                size: 40,
                                              ),
                                              tooltip: 'Go to Previous',
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.list,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      size: 30,
                                    ),
                                    const SizedBox(width: 30),
                                  ],
                                ),
                                const SizedBox(height: 100),
                                const Text(
                                  'Rest',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '00:$remainingSeconds',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                ),

                                // Add a row for the "Start" and "Next" buttons
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromARGB(54, 255, 255,
                                                  255), // Left color
                                              Color.fromARGB(54, 255, 255,
                                                  255), // Right color
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: TextButton(
                                          onPressed: addTime,
                                          child: const Text(
                                            '+20s',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 255, 255,
                                                  255), // Left color
                                              Color.fromARGB(255, 255, 255,
                                                  255), // Right color
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: TextButton(
                                          onPressed: skipExercise,
                                          child: const Text(
                                            'SKIP',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 87, 49, 235),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 100),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentExerciseIndex + 1 <
                                                widget.exercises.length
                                            ? 'NEXT ${currentExerciseIndex + 1}/${widget.exercises.length}'
                                            : 'No more exercises',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                        width: 400,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            currentExerciseIndex + 1 <
                                                    widget.exercises.length
                                                ? widget
                                                            .exercises[
                                                                currentExerciseIndex +
                                                                    1]
                                                            .name
                                                            .length >
                                                        22
                                                    ? '${widget.exercises[currentExerciseIndex + 1].name.substring(0, 22).toUpperCase()}...'
                                                    : widget
                                                        .exercises[
                                                            currentExerciseIndex +
                                                                1]
                                                        .name
                                                        .toUpperCase()
                                                : 'No more exercises',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'x10',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                  ),
                                  child: Image.network(
                                    widget.exercises[currentExerciseIndex + 1]
                                        .gifUrl,
                                    width: double.infinity,
                                    height: 400,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
