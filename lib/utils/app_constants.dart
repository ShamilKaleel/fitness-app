import 'package:flutter/material.dart';

class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://example.com/api';
  static const String userEndpoint = '$baseUrl/user';
  static const String authEndpoint = '$baseUrl/auth';

  // App-wide Colors
  static const Color yellow = Color(0xFFE2F163);
  static const Color purple = Color(0xFFB3A0FF);
  static const Color bgcColor = Color(0xFF232323);
  static const Color secondaryColor = Color(0xFF896CFE);
  static const Color primaryColor = Color(0xFF0073FE);

  // Spacing and Padding
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;

  // Font Sizes
  static const double titleFontSize = 24.0;
  static const double bodyFontSize = 16.0;

  // Other Text
  static const String appName = 'FitBody';
  static const String welcomeMessage = 'Welcome to FitBody!';

  // Onboarding Data
  static const List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to FitBody',
      'description': 'Your personal guide to staying fit and healthy!',
      'image':
          'https://stay-ease-booking-s3-bucket.s3.amazonaws.com/ee4a5c52f6d7a641a414377641cd98133e1a7b6cdc032eef9e3c0f9931ed4348.jpg', // Replace with actual URL
    },
    {
      'title': 'Track Your Progress',
      'description': 'Easily monitor your workout achievements.',
      'image':
          'https://stay-ease-booking-s3-bucket.s3.amazonaws.com/ee4a5c52f6d7a641a414377641cd98133e1a7b6cdc032eef9e3c0f9931ed4348.jpg', // Replace with actual URL
    },
    {
      'title': 'Stay Motivated',
      'description': 'Get personalized plans and stay on track.',
      'image':
          'https://stay-ease-booking-s3-bucket.s3.amazonaws.com/ee4a5c52f6d7a641a414377641cd98133e1a7b6cdc032eef9e3c0f9931ed4348.jpg', // Replace with actual URL
    },
  ];

  // List of body parts
  static const List<String> bodyParts = [
    "back",
    "cardio",
    "chest",
    "lower arms",
    "lower legs",
    "neck",
    "shoulders",
    "upper arms",
    "upper legs",
    "waist",
  ];
}
