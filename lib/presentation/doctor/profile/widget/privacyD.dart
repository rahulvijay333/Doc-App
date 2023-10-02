import 'package:flutter/material.dart';

class DoctorPrivacyPolicyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
       
        body: Column(
          children: [
      Container(
                  height: size.height * 0.07,
                  color: Colors.blue,
                  width: size.width,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            //----------------pop function
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                      const Text(
                        'Privacy',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
    
            const Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     
                      SizedBox(height: 16.0),
                      Text(
                        'This  Privacy Policy describes how we collect, use, and protect your personal information as a registered doctor on the AppointMedic app.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Information We Collect',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'When you register as a doctor on the AppointMedic app, we collect the following types of information:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Registration Information: To create and verify your doctor\'s account, we collect your full name, email address, phone number, professional qualifications, and any other required registration details.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Practice Information: We collect details about your medical practice, including your specialization, clinic/hospital name, address, and availability slots.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Communication Data: We collect data related to your interactions with patients and administrative staff, including appointment requests, messages, and other communication within the app.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'How We Use Your Information',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'We use the information we collect for the following purposes:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Verification and Credentialing: We use your registration information to verify your professional qualifications and credentials.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Appointment Management: Your practice information and availability slots are used to manage and schedule appointments with patients.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Communication: We use communication data to facilitate interactions between you and your patients and to provide customer support.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Legal Compliance: We may use and disclose your information to comply with legal or regulatory requirements.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Sharing Your Information',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'We may share your personal and professional information with:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Patients: Your practice information and availability slots are shared with patients to allow them to book appointments.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Administrative Staff: We may share relevant information with our administrative staff to support the smooth operation of the app.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '- Legal Requirements: We may disclose your information in response to lawful requests by public authorities or to meet legal and regulatory obligations.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Your Choices',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'You have the right to access, correct, or update your personal and professional information. You can manage your account settings within the app or contact our support team for assistance.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Security',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'We take reasonable measures to protect your information from unauthorized access, disclosure, or alteration. We implement industry-standard security practices to safeguard your data.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Changes to This Privacy Policy',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'We may update this Privacy Policy periodically to reflect changes in our practices or to comply with legal and regulatory requirements. You will be notified of any significant changes through the app or other means.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'If you have any questions or concerns about this Doctor Privacy Policy or our practices, please contact our support team at domain.test.mail333@gmail.com.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
