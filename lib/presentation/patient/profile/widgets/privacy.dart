import 'package:appoint_medic/core/color_constants.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyWidget extends StatelessWidget {
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
                    'Privacy',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    const SizedBox(height: 16.0),
                    const Text(
                      'This Privacy Policy explains how we collect, use, and protect your personal information when you use the AppointMedic app.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Information We Collect',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'When you use the AppointMedic app, we collect the following types of information:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Registration Information: To enable you to book appointments and use our services, we collect your registration details, including your name, email address, and phone number.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Usage Information: We collect data on how you interact with the app, including the features you use, timestamps of your interactions, and other usage statistics.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'How We Use Your Information',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'We use the information we collect for the following purposes:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Appointment Booking: Your registration information is used to enable you to book appointments with doctors through the app.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- App Improvement: We analyze usage data to enhance the app\'s functionality and user experience.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Communication: We may use your contact information to send you updates, notifications, and important information related to your appointments and the app\'s services.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Legal Compliance: We may disclose your information to comply with legal or regulatory requirements.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Sharing Your Information',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'We may share your personal information with:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Doctors: Your information is shared with doctors to facilitate appointments and provide medical services.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Service Providers: Third-party service providers may receive your information to assist in operating the app and delivering services.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '- Legal Requirements: We may disclose your information in response to lawful requests by public authorities, including those related to national security or law enforcement.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Your Choices',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'You have the right to access, correct, or delete your personal information. To do so, please contact us at domain.test.mail333@gmail.com. Please note that certain information may be retained as required by law or for legitimate business purposes.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Security',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'We take reasonable measures to protect your information from unauthorized access, disclosure, or alteration. However, no online method of data transmission is entirely secure, and absolute security cannot be guaranteed.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Changes to This Privacy Policy',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'We may update this Privacy Policy periodically to reflect changes in our practices, operational needs, or legal and regulatory requirements. Significant changes will be communicated through the app or other means.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'If you have any questions or concerns about this Privacy Policy or our practices, please reach out to us at domain.test.mail333@gmail.com.',
                      style: TextStyle(fontSize: 16.0),
                    ),
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
