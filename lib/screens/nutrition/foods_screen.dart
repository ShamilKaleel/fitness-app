import 'package:flutter/material.dart';
import 'package:fitnesapp/screens/nutrition/foods_category_screen.dart';

class FoodsScreen extends StatelessWidget {
  // Categories list limited to specified categories
  final List<String> categories = [
    'Nuts',
    'Protein',
    'Vegetable',
    'Grain',
    'Fruit',
    'Dairy',
  ];

  FoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Food Category'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(
                Icons.fastfood,
                color: Colors.teal,
              ),
              title: Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
              onTap: () {
                // Navigate to FoodsByCategoryScreen with selected category
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FoodsByCategoryScreen(category: category),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
