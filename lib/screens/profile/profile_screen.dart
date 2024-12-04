import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnesapp/screens/auth/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/utils/app_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userId;
  late String email;
  String? name;
  String? profileImageUrl;
  int? age;
  double? height;
  double? weight;
  String? gender;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    email = FirebaseAuth.instance.currentUser!.email!;
    fetchUserData();
  }

  // Fetch user data from Firestore
  void fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          name = userDoc['name'] ?? 'Unknown';
          profileImageUrl = userDoc['profileImageUrl'] ?? '';
          age = userDoc['age'];
          height = userDoc['height'];
          weight = userDoc['weight'];
          gender = userDoc['gender'];
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        showFormDialog();
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() => _isLoading = false);
    }
  }

  // Show form dialog to input missing data
  void showFormDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Complete Your Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: heightController,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: weightController,
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: genderController,
                    decoration: const InputDecoration(labelText: 'Gender'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your gender';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Save data to Firestore
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .set({
                          'name': nameController.text,
                          'email': email,
                          'profileImageUrl': '', // Add a default image URL
                          'age': int.parse(ageController.text),
                          'height': double.parse(heightController.text),
                          'weight': double.parse(weightController.text),
                          'gender': genderController.text,
                        });

                        Navigator.of(context).pop(); // Close the dialog
                        fetchUserData(); // Re-fetch user data
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Logout function
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, OnboardScreen.route());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Login Successful!',
              style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
          backgroundColor: AppConstants.yellow,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB3A0FF),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Info Section
            Container(
              color: const Color(0xFFB3A0FF),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage:
                        Image.asset('asset/image/profile(1).jpg').image,
                  ), // Replace with actual URL
                  const SizedBox(height: 12),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildInfoBox(
                            '${weight?.toStringAsFixed(1) ?? "Unknown"} Kg',
                            'Weight',
                            screenWidth),
                        buildInfoBox(
                            '${age ?? "Unknown"}', 'Years Old', screenWidth),
                        buildInfoBox(
                            '${height?.toStringAsFixed(1) ?? "Unknown"} CM',
                            'Height',
                            screenWidth),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  buildMenuItem(Icons.logout, 'Logout', onTap: logout),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoBox(String value, String label, double screenWidth) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget buildMenuItem(IconData icon, String title, {Function? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFB3A0FF)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.white70, size: 16),
          ],
        ),
      ),
    );
  }
}
