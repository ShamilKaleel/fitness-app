import 'package:flutter/material.dart';
import 'package:fitnesapp/utils/app_constants.dart';
import 'package:fitnesapp/screens/nutrition/foods_category_screen.dart';

class FoodsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> foodsImage = [
    {
      'category': 'carbohydrates',
      'image': Icons.fastfood,
    },
    {
      'category': 'proteins',
      'image': Icons.local_pizza,
    },
    {
      'category': 'fats',
      'image': Icons.lunch_dining,
    },
    {
      'category': 'minerals',
      'image': Icons.cake,
    },
    {
      'category': 'fiber',
      'image': Icons.rice_bowl,
    },
    {
      'category': 'antioxidants',
      'image': Icons.coffee,
    },
  ];

  FoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Food Category'),
      ),
      body: ListView.builder(
        itemCount: foodsImage.length,
        itemBuilder: (context, index) {
          final food = foodsImage[index];
          return card(
            child: Card(
              elevation: 0,
              surfaceTintColor: AppConstants.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(
                  food['image'] as IconData,
                  color: AppConstants.purple,
                  size: 40,
                ),
                title: Text(
                  capitalizeFirstLetter(food['category']!),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: AppConstants.purple),
                onTap: () {
                  // Navigate to FoodsByCategoryScreen with selected category
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FoodsByCategoryScreen(category: food['category']!),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
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

  String capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
