import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fitnesapp/widgets/gradient_button.dart';
import 'package:fitnesapp/widgets/bmi_bottom_sheet.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  String selectedGender = "Male";
  double height = 172.0;
  int weight = 58;
  int age = 22;

  double getBmi() {
    double bmi = weight / ((height / 100) * (height / 100));
    return bmi;
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: const Text('Your BMI'),
    //       content: Text(bmi.toStringAsFixed(2)),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: const Text('OK'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void onTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => BmiBottomSheet(
        userBmi: getBmi(),
      ),
      // resultCard(
      //   "BMI",
      //   getBmi().toStringAsFixed(2),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
              color: AppConstants.secondaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppConstants.bgcColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gender Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                genderCard("Male", Icons.male),
                const Spacer(),
                genderCard("Female", Icons.female),
              ],
            ),
            const SizedBox(height: 20),
            // Height Slider
            card(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Height (in cm)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    height.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Slider(
                    value: height,
                    min: 120.0,
                    max: 220.0,
                    divisions: 100,
                    activeColor: AppConstants.secondaryColor,
                    inactiveColor: AppConstants.purple.withOpacity(0.4),
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Weight and Age Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                counterCard('Weight', weight, (newValue) {
                  setState(() {
                    weight = newValue;
                  });
                }),
                const Spacer(),
                counterCard('Age', age, (newValue) {
                  setState(() {
                    age = newValue;
                  });
                }),
              ],
            ),
            const SizedBox(height: 25),
            // Calculate Button
            GradientButton(
              onPressed: onTap,
              text: 'Calculate BMI',
            ),
          ],
        ),
      ),
    );
  }

  Widget genderCard(String gender, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedGender == gender
              ? AppConstants.purple
              : const Color.fromARGB(255, 59, 59, 59),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 99, 99, 99)),
        ),
        height: MediaQuery.of(context).size.width * 0.43,
        width: MediaQuery.of(context).size.width * 0.43,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: selectedGender == gender ? Colors.black : Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              gender,
              style: TextStyle(
                color: selectedGender == gender ? Colors.black : Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 59, 59, 59),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 99, 99, 99)),
      ),
      child: child,
    );
  }

  Widget counterCard(String label, int value, Function(int) onUpdate) {
    return card(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    if (value > 1) onUpdate(value - 1);
                  },
                  icon: Container(
                      decoration: const BoxDecoration(
                        color: AppConstants
                            .secondaryColor, // Background color for the minus icon
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.remove)),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {
                    onUpdate(value + 1);
                  },
                  icon: Container(
                      decoration: const BoxDecoration(
                        color: AppConstants
                            .secondaryColor, // Background color for the minus icon
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.add)),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget resultCard(String label, String value) {
    return card(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 500,
        child: Column(
          children: [
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
