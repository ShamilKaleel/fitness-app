import 'package:flutter/material.dart';
import 'package:fitnesapp/widgets/card_body.dart'; // Adjust the import path as necessary
import 'package:fitnesapp/utils/app_constants.dart'; // Adjust the import path as necessary

class NutritionScreen extends StatelessWidget {
  NutritionScreen({super.key});
  final List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: ListView(children: [
              SizedBox(
                  height: 150,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 16),

                    scrollDirection:
                        Axis.horizontal, // Enables horizontal scrolling
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 370, // Fixed width for each item
                        margin: const EdgeInsets.only(
                            right: 10.0), // Spacing between items
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.teal, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal.shade800,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              ...AppConstants.bodyPartsImage.map<Widget>((bodyPartsImage) {
                return CardBody(
                  bodyPart: bodyPartsImage['name'] as String,
                  imageURL: bodyPartsImage['image'] as String,
                );
              })
            ]),
          ),
        ],
      ),
    );
  }
}
