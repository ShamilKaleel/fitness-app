import 'package:flutter/material.dart';
import 'package:fitnesapp/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLevel = 'Beginner'; // Track selected level
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text(
          'WORKOUT',
          style:
              TextStyle(color: Color(0xFF896CFE), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.person, color: Color(0xFF896CFE)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "It's time to challenge your limits.",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Beginner, Intermediate, Advanced buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLevelButton(context, 'Beginner'),
                _buildLevelButton(context, 'Intermediate'),
                _buildLevelButton(context, 'Advanced'),
              ],
            ),
            const SizedBox(height: 24),

            // Featured workout image
            Container(
              height: 190,
              decoration: const BoxDecoration(
                color: Color(0xFFB3A0FF),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF212020),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Beginner",
                              style: TextStyle(
                                color: Color(0xFFE2F163),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              "5 Workout Schedule",
                              style: TextStyle(
                                  color: Color.fromARGB(179, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          'https://stay-ease-booking-s3-bucket.s3.amazonaws.com/ee4a5c52f6d7a641a414377641cd98133e1a7b6cdc032eef9e3c0f9931ed4348.jpg', // Replace with a real image URL
                          height: 200,
                          width: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    "Let's Go Beginner",
                    style: TextStyle(
                        color: Color(0xFFE2F163),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Explore Different Workout Styles",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 16),

                  // Workout cards
                  _buildWorkoutGrid(),
                ],
              ),
            ),

            // List of workouts
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 5, 5, 12),
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Track Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'BMI',
          ),
        ],
      ),
    );
  }

  Widget _buildLevelButton(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedLevel = title;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedLevel == title
            ? const Color(0xFF896CFE)
            : const Color(0xFFE2F163),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selectedLevel == title ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildWorkoutGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 5, // Set the number of workouts here
      itemBuilder: (context, index) {
        return _buildWorkoutCard();
      },
    );
  }

  Widget _buildWorkoutCard() {
    return Card(
      color: const Color(0xFF2C2C2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              'https://stay-ease-booking-s3-bucket.s3.amazonaws.com/ee4a5c52f6d7a641a414377641cd98133e1a7b6cdc032eef9e3c0f9931ed4348.jpg', // Replace with real image URLs
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upper Body',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '60 Minutes  •  1320 Kcal',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '5 Exercises',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
