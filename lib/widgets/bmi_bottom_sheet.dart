import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // For circular gauge

class BmiBottomSheet extends StatelessWidget {
  const BmiBottomSheet({super.key, required this.userBmi});
  final double userBmi;

  final List<Map<String, dynamic>> bmiCategories = AppConstants.bmiCategories;

  String getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return "Healthy";
    } else if (bmi >= 25 && bmi <= 29.9) {
      return "Overweight";
    } else if (bmi >= 30 && bmi <= 34.9) {
      return "Obese";
    } else if (bmi >= 35 && bmi <= 39.9) {
      return "Highly Obese";
    } else {
      return "Extremely Obese";
    }
  }

  @override
  Widget build(BuildContext context) {
    String userCategory = getBmiCategory(userBmi);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 99, 99, 99),
          width: 1,
        ),
        color: AppConstants.bgcColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      height: 700,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 20),
            // BMI Title
            const Text(
              "Your BMI Result",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppConstants.secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            // Circular Gauge for BMI
            SizedBox(
              height: 300,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 15,
                    maximum: 40,
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        animationType: AnimationType.elasticOut,
                        value: userBmi,
                        needleColor: AppConstants.secondaryColor,
                        knobStyle:
                            const KnobStyle(color: AppConstants.secondaryColor),
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          userBmi.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            // BMI Categories List
            Expanded(
              child: ListView.builder(
                itemCount: bmiCategories.length,
                itemBuilder: (context, index) {
                  final category = bmiCategories[index];
                  final isHighlighted = category["category"] == userCategory;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: isHighlighted
                          ? AppConstants.purple
                          : const Color.fromARGB(255, 59, 59, 59),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isHighlighted
                            ? const Color.fromARGB(255, 114, 82, 241)
                            : const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        category["category"]!,
                        style: TextStyle(
                          fontWeight: isHighlighted
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isHighlighted ? Colors.black : Colors.white,
                        ),
                      ),
                      trailing: Text(
                        category["range"]!,
                        style: TextStyle(
                          color: isHighlighted ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
