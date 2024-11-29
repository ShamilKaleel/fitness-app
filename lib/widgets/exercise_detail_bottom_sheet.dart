import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import '../../models/exercise.dart';

class ExerciseDetailBottomSheet extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailBottomSheet({required this.exercise, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Top-left color
              AppConstants.secondaryColor,
              AppConstants.secondaryColor, // Bottom-right color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                exercise.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    exercise.gifUrl,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "TARGET MUSCLE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.yellow,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  exercise.target,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "INSTRUCTIONS",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.yellow),
              ),
              exercise.instructions[1].isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        exercise.instructions[1],
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : const SizedBox(),
              exercise.instructions[1].isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        exercise.instructions[1],
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 16),
              const Text(
                "SECONDARY MUSCLES",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.yellow,
                ),
              ),
              ...exercise.secondaryMuscles.map((muscle) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    muscle,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
