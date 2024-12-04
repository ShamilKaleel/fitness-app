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

// List of body parts with images
  static const List<Map<String, String>> bodyPartsImage = [
    {"name": "back", "image": "asset/image/Back/Back (4).jpg"},
    {"name": "cardio", "image": "asset/image/Cardio/Cardio (5).jpg"},
    {"name": "chest", "image": "asset/image/Chest/Chest (2).jpg"},
    {"name": "lower arms", "image": "asset/image/L&U Arms/Arms (8).jpg"},
    {"name": "upper arms", "image": "asset/image/L&U Arms/Arms (5).jpg"},
    {"name": "lower legs", "image": "asset/image/U&L Legs/Legs (9).jpg"},
    {"name": "upper legs", "image": "asset/image/U&L Legs/Legs (13).jpg"},
    {"name": "neck", "image": "asset/image/Neck/Neck (1).jpg"},
    {"name": "shoulders", "image": "asset/image/Shoulders/Shoulders (5).jpg"},
    {"name": "waist", "image": "asset/image/Waist/Waist (1).jpg"},
  ];

// List of BMI categories
  static const List<Map<String, dynamic>> bmiCategories = [
    {"range": "BMI < 18.5", "category": "Underweight"},
    {"range": "18.5–24.9", "category": "Healthy"},
    {"range": "25–29.9", "category": "Overweight"},
    {"range": "30–34.9", "category": "Obese"},
    {"range": "35–39.9", "category": "Highly Obese"},
    {"range": "40 >", "category": "Extremely Obese"},
  ];

// List of foods categories
  static const List<Map<String, String>> foodsImage = [
    {
      'category': 'carbohydrates',
      'image': 'asset/image/foods/carbohydrates.jpg',
    },
    {
      'category': 'proteins',
      'image': 'asset/image/foods/proteins.jpg',
    },
    {
      'category': 'fats',
      'image': 'asset/image/foods/fats.jpg',
    },
    {
      'category': 'minerals',
      'image': 'asset/image/foods/minerals.jpg',
    },
    {
      'category': 'fiber',
      'image': 'asset/image/foods/fiber.jpg',
    },
    {
      'category': 'antioxidants',
      'image': 'asset/image/foods/antioxidants.jpg',
    },
  ];
}
