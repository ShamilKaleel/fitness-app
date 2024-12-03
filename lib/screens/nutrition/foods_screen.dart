import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/screens/nutrition/foods_category_screen.dart';
import 'package:fitnesapp/utils/formatters.dart';

class FoodsScreen extends StatelessWidget {
  // Categories list limited to specified categories
  final List<String> categories = [
    'carbohydrates',
    'proteins',
    'fats',
    'minerals',
    'fiber',
    'antioxidants',
  ];

  FoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Food Category'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return card(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.fastfood,
                ),
                title: Text(
                  capitalizeFirstLetter(category),
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
                          FoodsByCategoryScreen(category: category),
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
}
