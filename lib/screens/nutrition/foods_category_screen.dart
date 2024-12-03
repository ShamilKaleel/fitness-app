import 'package:flutter/material.dart';
import 'package:fitnesapp/services/food_service.dart';
import 'package:fitnesapp/models/food.dart';

class FoodsByCategoryScreen extends StatefulWidget {
  final String category;

  const FoodsByCategoryScreen({super.key, required this.category});

  @override
  State<FoodsByCategoryScreen> createState() => _FoodsByCategoryScreenState();
}

class _FoodsByCategoryScreenState extends State<FoodsByCategoryScreen> {
  final FoodService _foodService = FoodService();
  late Future<List<Food>> _foodsFuture;

  @override
  void initState() {
    super.initState();
    _foodsFuture = _foodService.getFoodsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Foods'),
      ),
      body: FutureBuilder<List<Food>>(
        future: _foodsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No foods available in this category.'));
          } else {
            final foods = snapshot.data!;
            return ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return ListTile(
                  title: Text(food.name),
                  subtitle: Text('Calories: ${food.caloric} kcal'),
                  trailing: Text('${food.category}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
