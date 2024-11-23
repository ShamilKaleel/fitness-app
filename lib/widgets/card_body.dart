import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  final String bodyPart;

  final String imageURL;

  const CardBody({super.key, required this.bodyPart, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        color: Color(0xFFB3A0FF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xFF212020),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
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
                      style:
                          TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
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
    );
  }
}
