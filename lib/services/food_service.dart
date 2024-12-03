import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnesapp/models/food.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection name
  final String collectionName = 'foods';

  /// Get all Food entries
  Future<List<Food>> getAllFoods() async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) => Food.fromMap(doc.data())).toList();
    } catch (e) {
      print('Error fetching Foods: $e');
      throw Exception('Failed to fetch foods.');
    }
  }

  /// Get Food by category
  Future<List<Food>> getFoodsByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection(collectionName)
          .where('category', isEqualTo: category)
          .get();
      return snapshot.docs.map((doc) => Food.fromMap(doc.data())).toList();
    } catch (e) {
      print('Error fetching Foods by category: $e');
      throw Exception('Failed to fetch foods by category.');
    }
  }

  /// Upload a list of foods to Firestore
  Future<void> uploadFoods(List<Map<String, dynamic>> foodList) async {
    final batch = _firestore.batch();

    try {
      for (var food in foodList) {
        final docRef = _firestore.collection(collectionName).doc();
        batch.set(docRef, food);
      }

      await batch.commit();
      print('Food list uploaded successfully!');
    } catch (e) {
      print('Error uploading foods: $e');
      throw Exception('Failed to upload food list.');
    }
  }
}
