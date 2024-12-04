import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnesapp/models/user.dart';

class UserDetailsFormPage extends StatefulWidget {
  const UserDetailsFormPage({super.key});

  @override
  State<UserDetailsFormPage> createState() => _UserDetailsFormPageState();
}

class _UserDetailsFormPageState extends State<UserDetailsFormPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  int age = 18;
  double height = 170.0;
  double weight = 70.0;
  String gender = 'Male';
  List<String> favoriteWorkouts = [];

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create the user model object
      UserModel userModel = UserModel(
        name: name,
        email: email,
        age: age,
        height: height,
        weight: weight,
        gender: gender,
        favoriteWorkouts: favoriteWorkouts,
      );

      // Store the user model in Firestore
      FirebaseFirestore.instance
          .collection('users')
          .add(userModel.toMap())
          .then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User details saved!')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Fitness Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => name = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => email = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => age = int.parse(value!),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your age' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => height = double.parse(value!),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your height' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => weight = double.parse(value!),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your weight' : null,
                ),
                DropdownButtonFormField<String>(
                  value: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  items: ['Male', 'Female', 'Other']
                      .map((gender) =>
                          DropdownMenuItem(child: Text(gender), value: gender))
                      .toList(),
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Favorite Workouts'),
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      favoriteWorkouts = value.split(',');
                    }
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter favorite workouts' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
