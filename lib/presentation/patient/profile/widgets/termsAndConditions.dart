import 'package:appoint_medic/core/color_constants.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: size.height * 0.07,
              width: size.width,
              color: appBackGround,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        //------------------------------pop function
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                  const Text(
                    'Terms and Conditions',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
             Expanded(
               child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      'By using the AppointMedic app, you agree to comply with and be bound by the following Terms and Conditions. Please review these terms carefully.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'User Responsibilities',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'As a user of the AppointMedic app, you are responsible for:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Providing accurate and complete registration information.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Maintaining the confidentiality of your account credentials.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Using the app in compliance with all applicable laws and regulations.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'User Conduct',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'You agree not to:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Use the app for any unlawful purpose or in violation of any applicable laws.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Attempt to gain unauthorized access to any portion of the app or any related systems or networks.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Upload, transmit, or share any content that is harmful, offensive, or violates the rights of others.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Engage in any activity that disrupts or interferes with the app\'s functionality.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    // Continue adding sections as needed based on your Terms and Conditions content.
                  ],
                ),
                         ),
             ),
          ],
        ),
      ),
    );
  }
}
