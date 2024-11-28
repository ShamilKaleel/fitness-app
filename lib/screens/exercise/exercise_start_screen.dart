import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import '../../models/exercise.dart';

import 'congratulation_screen.dart';

import 'package:fitnesapp/widgets/exercise_progress_bar.dart';

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const CongratulationsScreen()),
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
      if (remainingSeconds == 0) {
        goToNextExercise();
      }
    });
  }

  void cancelExercise() {
    // Go back to the ExerciseScreen when the user wants to cancel
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CongratulationsScreen()),
    );
  }

  void goToPreviousExercise() {
    // Go back to the Exercise when the user wants to go back
    setState(() {
      currentExerciseIndex--;
      currentExercise = widget.exercises[currentExerciseIndex];
    });
  }

  void addTime() {
    // Add 20 seconds to the rest period
    setState(() {
      remainingSeconds += 20;
    });
    startRestTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                !isRestPeriod
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color.fromARGB(255, 123, 96, 234), // Top-left color
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
                            padding:
                                const EdgeInsets.only(left: 0.0, right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: cancelExercise,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent),
                                  child: const Icon(Icons.close,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                      size: 30),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      widget.exercises[currentExerciseIndex + 1]
                                                  .name.length >
                                              30
                                          ? '${widget.exercises[currentExerciseIndex + 1].name.substring(0, 30).toUpperCase()}...'
                                          : widget
                                              .exercises[
                                                  currentExerciseIndex + 1]
                                              .name
                                              .toUpperCase(),
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
                                                  color: Colors.grey[300]!,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      40), // Rounded border
                                            ),
                                            child: IconButton(
                                              onPressed: goToPreviousExercise,
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
                                            AppConstants.purple, // Left color
                                            Color.fromARGB(255, 100, 75,
                                                197), // Right color
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: TextButton(
                                        onPressed: goToNextExercise,
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
                                            color: Colors.grey[300]!, width: 1),
                                        borderRadius: BorderRadius.circular(
                                            40), // Rounded border
                                      ),
                                      child: IconButton(
                                        onPressed: goToNextExercise,
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
                                        Color.fromARGB(
                                            54, 255, 255, 255), // Left color
                                        Color.fromARGB(
                                            54, 255, 255, 255), // Right color
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
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
                                        Color.fromARGB(
                                            255, 255, 255, 255), // Left color
                                        Color.fromARGB(
                                            255, 255, 255, 255), // Right color
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: TextButton(
                                    onPressed: goToNextExercise,
                                    child: const Text(
                                      'SKIP',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 87, 49, 235),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NEXT ${currentExerciseIndex + 1}/${widget.exercises.length}',
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
                                      widget.exercises[currentExerciseIndex + 1]
                                                  .name.length >
                                              22
                                          ? '${widget.exercises[currentExerciseIndex + 1].name.substring(0, 22).toUpperCase()}...'
                                          : widget
                                              .exercises[
                                                  currentExerciseIndex + 1]
                                              .name
                                              .toUpperCase(),
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
                              widget.exercises[currentExerciseIndex + 1].gifUrl,
                              width: double.infinity,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),

                // ElevatedButton(
                //   onPressed: cancelExercise,
                //   child: const Text('Cancel and Go Back'),
                // ),
                // const SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: goToNextExercise,
                //   child: const Text('Next Exercise'),
                // ),
                // const SizedBox(
                //   height: 20,
                //   width: double.infinity,
                // ),
                // ElevatedButton(
                //   onPressed: cancelExercise,
                //   child: const Text('Cancel and Go Back'),
                // ),
                // const SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: goToNextExercise,
                //   child: const Text('Next Exercise'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
