import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/services/food_service.dart';
import 'package:fitnesapp/models/food.dart';
import 'package:fitnesapp/utils/formatters.dart';

class FoodsByCategoryScreen extends StatefulWidget {
  final String category;

  const FoodsByCategoryScreen({super.key, required this.category});

  @override
  State<FoodsByCategoryScreen> createState() => _FoodsByCategoryScreenState();
}

class _FoodsByCategoryScreenState extends State<FoodsByCategoryScreen> {
  final FoodService _foodService = FoodService();
  late Future<List<Food>> _foodsFuture;
  List<Food> _foods = [];
  String _sortCriteria = 'caloric';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _foodsFuture = _fetchAndSortFoods();
  }

  Future<List<Food>> _fetchAndSortFoods() async {
    final foods = await _foodService.getFoodsByCategory(widget.category);
    return _sortFoods(foods, _sortCriteria, _isAscending);
  }

  List<Food> _sortFoods(List<Food> foods, String criteria, bool ascending) {
    foods.sort((a, b) {
      final valueA = _getComparableValue(a, criteria);
      final valueB = _getComparableValue(b, criteria);
      if (ascending) {
        return valueA.compareTo(valueB);
      } else {
        return valueB.compareTo(valueA);
      }
    });
    return foods;
  }

  dynamic _getComparableValue(Food food, String criteria) {
    switch (criteria) {
      case 'caloric':
        return food.caloric;
      case 'fat':
        return food.fat;
      case 'carbon':
        return food.carbon;
      case 'protein':
        return food.protein;
      default:
        return 0;
    }
  }

  void _onSortChanged(String newCriteria, bool ascending) {
    setState(() {
      _sortCriteria = newCriteria;
      _isAscending = ascending;
      _foodsFuture = _fetchAndSortFoods();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${capitalizeFirstLetter(widget.category)} Foods'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 8, // Allocates space for the ToggleButtons
                      child: ToggleButtons(
                        isSelected: [
                          _sortCriteria == 'caloric',
                          _sortCriteria == 'fat',
                          _sortCriteria == 'carbon',
                          _sortCriteria == 'protein',
                        ],
                        onPressed: (index) {
                          const criteria = [
                            'caloric',
                            'fat',
                            'carbon',
                            'protein'
                          ];
                          _onSortChanged(criteria[index], _isAscending);
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        borderColor: Colors.grey
                            .shade700, // Border color for unselected buttons
                        selectedBorderColor: AppConstants
                            .secondaryColor, // Border color for selected button
                        fillColor: AppConstants.purple.withOpacity(
                            0.6), // Background color for selected button
                        color: Colors
                            .grey.shade500, // Text color for unselected buttons
                        selectedColor:
                            Colors.white, // Text color for selected button
                        splashColor:
                            AppConstants.secondaryColor.withOpacity(0.3),
                        constraints: BoxConstraints.expand(
                          width: MediaQuery.of(context).size.width /
                              5, // Dynamic width
                          height: 50, // Button height
                        ),
                        children: const [
                          Text(
                            "Calories",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text("Fat", textAlign: TextAlign.center),
                          Text("Carbs", textAlign: TextAlign.center),
                          Text("Protein", textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1, // Allocates 1 part for the IconButton
                      child: IconButton(
                        icon: Icon(
                          _isAscending
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward,
                          color: _isAscending ? Colors.red : Colors.green,
                        ),
                        onPressed: () {
                          _onSortChanged(_sortCriteria, !_isAscending);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Food>>(
              future: _foodsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No foods available in this category.'));
                } else {
                  _foods = snapshot.data!;
                  return ListView.builder(
                    itemCount: _foods.length,
                    itemBuilder: (context, index) {
                      final food = _foods[index];
                      return card(
                        child: ListTile(
                          title: Text(food.name),
                          subtitle: Text('Calories: ${food.caloric} kcal'),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Fat: ${food.fat}g'),
                              Text('Protein: ${food.protein}g'),
                              Text('Carbs: ${food.carbon}g'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget card({required ListTile child}) {
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
