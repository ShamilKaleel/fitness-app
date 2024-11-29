import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/exercise.dart';
import 'timer_screen.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/card_exercise.dart';
import 'package:fitnesapp/utils/formatters.dart';
import '../../widgets/exercise_detail_bottom_sheet.dart';

class ExerciseScreen extends StatefulWidget {
  final String bodyPart;

  const ExerciseScreen({required this.bodyPart, super.key});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late Future<List<Exercise>> exercises;

  @override
  void initState() {
    super.initState();
    exercises = ApiService.fetchExercises(widget.bodyPart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${capitalizeFirstLetter(widget.bodyPart)} Exercises'),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: exercises,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exercises found.'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final exercise = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) =>
                                ExerciseDetailBottomSheet(exercise: exercise),
                          );
                        },
                        child: CardExercise(
                          gifUrl: exercise.gifUrl,
                          title: exercise.name,
                          repetitions: "x10",
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GradientButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerScreen(
                            exercises: snapshot.data!,
                          ),
                        ),
                      );
                    },
                    text: 'Start Workout',
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
