import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/screen/login_screen.dart'; // Adjust the path as necessary

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  List<Map<String, dynamic>> onboardingData = [
    {
      "image":
          "asset/image/beautiful-young-sporty-woman-training-workout-gym.png",
      "title": "Start Your Journey Towards A More Active Lifestyle",
      "icon": Icons.fitness_center, // Material icon for fitness
    },
    {
      "image":
          "asset/image/beautiful-young-sporty-woman-training-workout-gym1.png",
      "title": "Find Nutrition Tips That Fit Your Lifestyle",
      "icon": Icons.restaurant, // Material icon for nutrition
    },
    {
      "image":
          "asset/image/beautiful-young-sporty-woman-training-workout-gym2.png",
      "title": "A Community For You, Challenge Yourself",
      "icon": Icons.group, // Material icon for community
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Background image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(onboardingData[index]["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Semi-transparent overlay
                  Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  // Content
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      color: AppConstants.purple,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon
                          Icon(
                            onboardingData[index]["icon"],
                            size: 60,
                            color: AppConstants.yellow,
                          ),
                          const SizedBox(height: 20),
                          // Title text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              onboardingData[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // Skip button
          Positioned(
            top: 50,
            right: 20,
            child: _currentPage != onboardingData.length - 1
                ? TextButton(
                    onPressed: () {
                      _controller.jumpToPage(onboardingData.length - 1);
                    },
                    child: const Text(
                      'Skip',
                      style:
                          TextStyle(color: AppConstants.yellow, fontSize: 16),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          // Bottom navigation
          Positioned(
            bottom: 290,
            left: 20,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Page indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Next or Get Started button
                _currentPage == onboardingData.length - 1
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                              .withOpacity(0.2), // Transparent background
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent, // No shadow
                          side: const BorderSide(
                              color: Colors.white, width: 1), // White outline
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(200, 40),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: const Text('Get Started'),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                              .withOpacity(0.2), // Transparent background
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent, // No shadow
                          side: const BorderSide(
                              color: Colors.white, width: 1), // White outline
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(200, 40),
                        ),
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        child: const Text('Next'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
