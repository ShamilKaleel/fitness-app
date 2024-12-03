// import 'package:flutter/material.dart';
// import 'package:fitnesapp/services/food_service.dart';
// import 'package:fitnesapp/models/food.dart';

// class FoodsScreen extends StatefulWidget {
//   const FoodsScreen({super.key});

//   @override
//   _FoodsScreenState createState() => _FoodsScreenState();
// }

// class _FoodsScreenState extends State<FoodsScreen> {
//   final FoodService _foodService = FoodService();
//   late Future<List<Food>> _foodsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _foodsFuture = _foodService.getAllFoods();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Foods'),
//       ),
//       body: FutureBuilder<List<Food>>(
//         future: _foodsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No foods available.'));
//           } else {
//             final foods = snapshot.data!;
//             return ListView.builder(
//               itemCount: foods.length,
//               itemBuilder: (context, index) {
//                 final food = foods[index];
//                 return ListTile(
//                   title: Text(food.name),
//                   subtitle: Text('Calories: ${food.caloric} kcal'),
//                   trailing: Text('${food.category}'),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
