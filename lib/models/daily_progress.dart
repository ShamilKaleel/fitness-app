class DailyProgress {
  final int id;
  final int doneExercise;
  final int totalExercise;
  final DateTime date;
  final String userId; // Foreign key to User
  final String bodyPart; // Foreign key to Schedule

  DailyProgress({
    required this.id,
    required this.doneExercise,
    required this.totalExercise,
    required this.date,
    required this.userId,
    required this.bodyPart,
  });

  /// Convert a DailyProgress object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doneExercise': doneExercise,
      'totalExercise': totalExercise,
      'date': date.toIso8601String(),
      'userId': userId,
      'bodyPart': bodyPart,
    };
  }

  /// Create a DailyProgress object from a Map
  factory DailyProgress.fromMap(Map<String, dynamic> map) {
    return DailyProgress(
      id: map['id'] as int,
      doneExercise: map['doneExercise'] as int,
      totalExercise: map['totalExercise'] as int,
      date: DateTime.parse(map['date'] as String),
      userId: map['userId'] as String,
      bodyPart: map['bodyPart'] as String,
    );
  }
}
