// import 'package:cloud_firestore/cloud_firestore.dart';

// void uploadFoodsToFirestore() async {
//   // Initialize Firestore instance
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // Food list
//   List<Map<String, dynamic>> foods = [
//     {
//       "id": "2049",
//       "name": "Yogurt",
//       "caloric": "99",
//       "fat": "1.15",
//       "carbon": "18.6",
//       "protein": "3.98",
//       "category": "Dairy"
//     },
//     {
//       "id": "13035",
//       "name": "Milk",
//       "caloric": "42",
//       "fat": "1.0",
//       "carbon": "5.0",
//       "protein": "3.4",
//       "category": "Dairy"
//     },
//     {
//       "id": "13036",
//       "name": "Cheese",
//       "caloric": "402",
//       "fat": "33.1",
//       "carbon": "1.3",
//       "protein": "25.0",
//       "category": "Dairy"
//     },
//     {
//       "id": "13037",
//       "name": "Cottage Cheese",
//       "caloric": "98",
//       "fat": "4.3",
//       "carbon": "3.4",
//       "protein": "11.1",
//       "category": "Dairy"
//     },
//     {
//       "id": "13038",
//       "name": "Butter",
//       "caloric": "717",
//       "fat": "81.1",
//       "carbon": "0.1",
//       "protein": "0.9",
//       "category": "Dairy"
//     },
//     {
//       "id": "13039",
//       "name": "Cream",
//       "caloric": "455",
//       "fat": "48.0",
//       "carbon": "3.0",
//       "protein": "2.0",
//       "category": "Dairy"
//     },
//     {
//       "id": "2461",
//       "name": "Oranges",
//       "caloric": "47",
//       "fat": "0.12",
//       "carbon": "11.7",
//       "protein": "0.94",
//       "category": "Fruit"
//     },
//     {
//       "id": "2407",
//       "name": "Apples",
//       "caloric": "52",
//       "fat": "0.17",
//       "carbon": "13.8",
//       "protein": "0.26",
//       "category": "Fruit"
//     },
//     {
//       "id": "9991",
//       "name": "Mango",
//       "caloric": "60",
//       "fat": "0.38",
//       "carbon": "15",
//       "protein": "0.82",
//       "category": "Fruit"
//     },
//     {
//       "id": "9992",
//       "name": "Pineapple",
//       "caloric": "50",
//       "fat": "0.12",
//       "carbon": "13.12",
//       "protein": "0.54",
//       "category": "Fruit"
//     },
//     {
//       "id": "9993",
//       "name": "Strawberry",
//       "caloric": "32",
//       "fat": "0.3",
//       "carbon": "7.7",
//       "protein": "0.7",
//       "category": "Fruit"
//     },
//     {
//       "id": "2027",
//       "name": "Bananas",
//       "caloric": "89",
//       "fat": "0.33",
//       "carbon": "22.8",
//       "protein": "1.09",
//       "category": "Fruit"
//     },
//     {
//       "id": "13033",
//       "name": "Rice",
//       "caloric": "206",
//       "fat": "0.4",
//       "carbon": "44.6",
//       "protein": "4.3",
//       "category": "Grain"
//     },
//     {
//       "id": "13034",
//       "name": "Corn",
//       "caloric": "365",
//       "fat": "4.7",
//       "carbon": "74.3",
//       "protein": "9.4",
//       "category": "Grain"
//     },
//     {
//       "id": "1307",
//       "name": "Oats",
//       "caloric": "85",
//       "fat": "1.5",
//       "carbon": "22",
//       "protein": "2",
//       "category": "Grain"
//     },
//     {
//       "id": "8062",
//       "name": "Barley",
//       "caloric": "354",
//       "fat": "2.3",
//       "carbon": "73.4",
//       "protein": "12.4",
//       "category": "Grain"
//     },
//     {
//       "id": "13032",
//       "name": "Quinoa",
//       "caloric": "374",
//       "fat": "5.79",
//       "carbon": "68.8",
//       "protein": "13",
//       "category": "Grain"
//     },
//     {
//       "id": "9998",
//       "name": "Brown Rice",
//       "caloric": "215",
//       "fat": "1.8",
//       "carbon": "45",
//       "protein": "5",
//       "category": "Grain"
//     },
//     {
//       "id": "1712",
//       "name": "Beets",
//       "caloric": "43",
//       "fat": "0.17",
//       "carbon": "9.56",
//       "protein": "1.61",
//       "category": "Vegetable"
//     },
//     {
//       "id": "10001",
//       "name": "Spinach",
//       "caloric": "23",
//       "fat": "0.4",
//       "carbon": "3.6",
//       "protein": "2.9",
//       "category": "Vegetable"
//     },
//     // The rest of the list continues similarly...
//   ];

//   // Add the rest of your food items here

//   // Reference to the "foods" collection
//   CollectionReference foodsCollection = firestore.collection('foods');

//   for (var food in foods) {
//     try {
//       // Upload each food item
//       await foodsCollection.doc(food['id']).set(food);
//       print("Uploaded: ${food['name']}");
//     } catch (e) {
//       print("Error uploading ${food['name']}: $e");
//     }
//   }

//   print("All foods uploaded successfully!");
// }
