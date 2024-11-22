import 'package:flutter/material.dart';

class CardExercise extends StatelessWidget {
  final String gifUrl;
  final String title;
  final String repetitions;

  const CardExercise({
    super.key,
    required this.gifUrl,
    required this.title,
    required this.repetitions,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                gifUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.length > 34
                      ? title.substring(0, 34).toUpperCase()
                      : title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  repetitions,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
