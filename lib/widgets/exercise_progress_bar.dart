import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ExerciseProgressBar extends StatelessWidget {
  final int scheduleSize; // Total number of exercises in the schedule
  final int doneCount; // Number of completed exercises

  const ExerciseProgressBar({
    super.key,
    required this.scheduleSize,
    required this.doneCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(scheduleSize, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          width: 35,
          height: 5,
          decoration: BoxDecoration(
            color: index < doneCount ? AppConstants.purple : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
