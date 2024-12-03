import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/screens/exercise/exercise_screen.dart';
import 'package:fitnesapp/services/firebase_auth_service.dart';
import 'package:fitnesapp/widgets/card_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> bodyParts = AppConstants.bodyParts;
  final authService = FirebaseAuthService();

  void uploadFoodsToFirestore() async {
    // Initialize Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Food list
    List<Map<String, dynamic>> foods = [
      {
        "id": "2049",
        "name": "Yogurt",
        "caloric": "99",
        "fat": "1.15",
        "carbon": "18.6",
        "protein": "3.98",
        "category": "Dairy"
      },
      {
        "id": "13035",
        "name": "Milk",
        "caloric": "42",
        "fat": "1.0",
        "carbon": "5.0",
        "protein": "3.4",
        "category": "Dairy"
      },
      {
        "id": "13036",
        "name": "Cheese",
        "caloric": "402",
        "fat": "33.1",
        "carbon": "1.3",
        "protein": "25.0",
        "category": "Dairy"
      },
      {
        "id": "13037",
        "name": "Cottage Cheese",
        "caloric": "98",
        "fat": "4.3",
        "carbon": "3.4",
        "protein": "11.1",
        "category": "Dairy"
      },
      {
        "id": "13038",
        "name": "Butter",
        "caloric": "717",
        "fat": "81.1",
        "carbon": "0.1",
        "protein": "0.9",
        "category": "Dairy"
      },
      {
        "id": "13039",
        "name": "Cream",
        "caloric": "455",
        "fat": "48.0",
        "carbon": "3.0",
        "protein": "2.0",
        "category": "Dairy"
      },
      {
        "id": "2461",
        "name": "Oranges",
        "caloric": "47",
        "fat": "0.12",
        "carbon": "11.7",
        "protein": "0.94",
        "category": "Fruit"
      },
      {
        "id": "2407",
        "name": "Apples",
        "caloric": "52",
        "fat": "0.17",
        "carbon": "13.8",
        "protein": "0.26",
        "category": "Fruit"
      },
      {
        "id": "9991",
        "name": "Mango",
        "caloric": "60",
        "fat": "0.38",
        "carbon": "15",
        "protein": "0.82",
        "category": "Fruit"
      },
      {
        "id": "9992",
        "name": "Pineapple",
        "caloric": "50",
        "fat": "0.12",
        "carbon": "13.12",
        "protein": "0.54",
        "category": "Fruit"
      },
      {
        "id": "9993",
        "name": "Strawberry",
        "caloric": "32",
        "fat": "0.3",
        "carbon": "7.7",
        "protein": "0.7",
        "category": "Fruit"
      },
      {
        "id": "2027",
        "name": "Bananas",
        "caloric": "89",
        "fat": "0.33",
        "carbon": "22.8",
        "protein": "1.09",
        "category": "Fruit"
      },
      {
        "id": "13033",
        "name": "Rice",
        "caloric": "206",
        "fat": "0.4",
        "carbon": "44.6",
        "protein": "4.3",
        "category": "Grain"
      },
      {
        "id": "13034",
        "name": "Corn",
        "caloric": "365",
        "fat": "4.7",
        "carbon": "74.3",
        "protein": "9.4",
        "category": "Grain"
      },
      {
        "id": "1307",
        "name": "Oats",
        "caloric": "85",
        "fat": "1.5",
        "carbon": "22",
        "protein": "2",
        "category": "Grain"
      },
      {
        "id": "8062",
        "name": "Barley",
        "caloric": "354",
        "fat": "2.3",
        "carbon": "73.4",
        "protein": "12.4",
        "category": "Grain"
      },
      {
        "id": "13032",
        "name": "Quinoa",
        "caloric": "374",
        "fat": "5.79",
        "carbon": "68.8",
        "protein": "13",
        "category": "Grain"
      },
      {
        "id": "9998",
        "name": "Brown Rice",
        "caloric": "215",
        "fat": "1.8",
        "carbon": "45",
        "protein": "5",
        "category": "Grain"
      },
      {
        "id": "1712",
        "name": "Beets",
        "caloric": "43",
        "fat": "0.17",
        "carbon": "9.56",
        "protein": "1.61",
        "category": "Vegetable"
      },
      {
        "id": "10001",
        "name": "Spinach",
        "caloric": "23",
        "fat": "0.4",
        "carbon": "3.6",
        "protein": "2.9",
        "category": "Vegetable"
      },
      {
        "id": "10002",
        "name": "Broccoli",
        "caloric": "55",
        "fat": "0.6",
        "carbon": "11.2",
        "protein": "4.0",
        "category": "Vegetable"
      },
      {
        "id": "2111",
        "name": "Carrots",
        "caloric": "41",
        "fat": "0.24",
        "carbon": "9.58",
        "protein": "0.93",
        "category": "Vegetable"
      },
      {
        "id": "5276",
        "name": "Ginger",
        "caloric": "80",
        "fat": "0.75",
        "carbon": "17.7",
        "protein": "1.82",
        "category": "Vegetable"
      },
      {
        "id": "11716",
        "name": "Beans",
        "caloric": "78",
        "fat": "0",
        "carbon": "13",
        "protein": "5",
        "category": "Vegetable"
      },
      {
        "id": "1742",
        "name": "Egg",
        "caloric": "147",
        "fat": "9.94",
        "carbon": "0.77",
        "protein": "12.5",
        "category": "Protein"
      },
      {
        "id": "85",
        "name": "Tofu",
        "caloric": "76",
        "fat": "4.2",
        "carbon": "2.4",
        "protein": "7.8",
        "category": "Protein"
      },
      {
        "id": "1610",
        "name": "Salmon",
        "caloric": "146",
        "fat": "5.93",
        "carbon": "0",
        "protein": "21.6",
        "category": "Protein"
      },
      {
        "id": "3576",
        "name": "Turkey",
        "caloric": "187",
        "fat": "7.02",
        "carbon": "0",
        "protein": "28.9",
        "category": "Protein"
      },
      {
        "id": "8499",
        "name": "Chicken",
        "caloric": "205",
        "fat": "16",
        "carbon": "2",
        "protein": "13",
        "category": "Protein"
      },
      {
        "id": "10006",
        "name": "Chicken Breast",
        "caloric": "165",
        "fat": "3.6",
        "carbon": "0",
        "protein": "31",
        "category": "Protein"
      },
      {
        "id": "252",
        "name": "Walnuts",
        "caloric": "680",
        "fat": "64.3",
        "carbon": "16.2",
        "protein": "14.3",
        "category": "Nuts"
      },
      {
        "id": "3042",
        "name": "Almonds",
        "caloric": "576",
        "fat": "49.9",
        "carbon": "22.1",
        "protein": "21.1",
        "category": "Nuts"
      },
      {
        "id": "9994",
        "name": "Cashews",
        "caloric": "553",
        "fat": "44.9",
        "carbon": "30.2",
        "protein": "18.2",
        "category": "Nuts"
      },
      {
        "id": "10007",
        "name": "Peanuts",
        "caloric": "567",
        "fat": "49.2",
        "carbon": "16.1",
        "protein": "25.8",
        "category": "Nuts"
      },
      {
        "id": "9996",
        "name": "Hazelnuts",
        "caloric": "628",
        "fat": "60.0",
        "carbon": "16.7",
        "protein": "15.0",
        "category": "Nuts"
      },
      {
        "id": "4055",
        "name": "Chia seeds",
        "caloric": "486",
        "fat": "30.7",
        "carbon": "42.1",
        "protein": "16.5",
        "category": "Nuts"
      }
    ];

    // Reference to the "foods" collection
    CollectionReference foodsCollection = firestore.collection('foods');

    for (var food in foods) {
      try {
        // Upload each food item
        await foodsCollection.doc(food['id']).set(food);
        print("Uploaded: ${food['name']}");
      } catch (e) {
        print("Error uploading ${food['name']}: $e");
      }
    }

    print("All foods uploaded successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workouts',
                style: TextStyle(
                    fontSize: 24,
                    color: AppConstants.secondaryColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left),
            Text(
              'Choose a body part to get started!',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.person, color: Color(0xFF896CFE)),
              onPressed: () async {
                uploadFoodsToFirestore();
                // await authService.signOut();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: ListView.builder(
          itemCount: AppConstants.bodyPartsImage.length,
          itemBuilder: (context, index) {
            return CardBody(
              bodyPart: (AppConstants.bodyPartsImage[index]['name'] as String),
              imageURL: AppConstants.bodyPartsImage[index]['image'] as String,
            );
          },
        ),
      ),
    );
  }
}
