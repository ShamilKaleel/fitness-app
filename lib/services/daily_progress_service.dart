import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnesapp/models/daily_progress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DailyProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection name
  final String collectionName = 'daily_progress';

  /// Add a new DailyProgress entry
  Future<void> addDailyProgress(DailyProgress dailyProgress) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(dailyProgress.id.toString())
          .set(dailyProgress.toMap());
    } catch (e) {
      print('Error adding DailyProgress: $e');
      throw Exception('Failed to add daily progress.');
    }
  }

  /// Get all DailyProgress entries
  Future<List<DailyProgress>> getAllDailyProgress() async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs
          .map((doc) => DailyProgress.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting DailyProgress: $e');
      throw Exception('Failed to fetch daily progress.');
    }
  }

  /// Get DailyProgress by date and userId
  Future<List<DailyProgress>> getDailyProgressByDateAndUser(
      DateTime date, String userId) async {
    try {
      final snapshot = await _firestore
          .collection(collectionName)
          .where('userId', isEqualTo: userId)
          .where('date', isEqualTo: date.toIso8601String())
          .get();
      return snapshot.docs
          .map((doc) => DailyProgress.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting DailyProgress by date and user: $e');
      throw Exception('Failed to fetch daily progress by date and user.');
    }
  }

  /// Update a DailyProgress entry
  Future<void> updateDailyProgress(DailyProgress dailyProgress) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(dailyProgress.id.toString())
          .update(dailyProgress.toMap());
    } catch (e) {
      print('Error updating DailyProgress: $e');
      throw Exception('Failed to update daily progress.');
    }
  }

  /// Delete a DailyProgress entry by ID
  Future<void> deleteDailyProgress(int id) async {
    try {
      await _firestore.collection(collectionName).doc(id.toString()).delete();
    } catch (e) {
      print('Error deleting DailyProgress: $e');
      throw Exception('Failed to delete daily progress.');
    }
  }

  Future<List<DailyProgress>> getDailyProgressByDate(DateTime date) async {
    try {
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(date); // Format the date
      final snapshot = await _firestore
          .collection(collectionName)
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .where('date', isEqualTo: formattedDate) // Compare only `yyyy-MM-dd`
          .get();

      return snapshot.docs
          .map((doc) => DailyProgress.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching DailyProgress for date: $e');
      throw Exception('Failed to fetch progress for the selected date.');
    }
  }
}
