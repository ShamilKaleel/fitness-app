import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitnesapp/models/daily_progress.dart';
import 'package:fitnesapp/utils/app_constants.dart';

class ProgressListView extends StatelessWidget {
  final List<DailyProgress> _progressList;
  final Function(int id) _deleteProgress;

  const ProgressListView({
    super.key,
    required List<DailyProgress> progressList,
    required Function(int id) deleteProgress,
  })  : _progressList = progressList,
        _deleteProgress = deleteProgress;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _progressList.length,
      itemBuilder: (context, index) {
        final progress = _progressList[index];
        final percentage =
            (progress.doneExercise / progress.totalExercise).clamp(0.0, 1.0);

        return Dismissible(
          key: Key(progress.id.toString()), // Unique key for each item
          direction: DismissDirection.endToStart, // Swipe right to left
          onDismissed: (direction) {
            // Call the delete function when dismissed
            _deleteProgress(progress.id);
          },
          background: Container(
            color: AppConstants.yellow,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.black),
          ),
          child: card(
            child: Card(
              color: const Color.fromARGB(255, 48, 48, 48),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  'Body Part: ${progress.bodyPart}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(progress.date)}\n'
                      'Exercises: ${progress.doneExercise}/${progress.totalExercise}',
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: percentage,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        percentage >= 0.7
                            ? Colors.green
                            : percentage >= 0.4
                                ? Colors.orange
                                : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget card({required Card child}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 48, 48, 48),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromARGB(255, 99, 99, 99)),
    ),
    child: child,
  );
}
