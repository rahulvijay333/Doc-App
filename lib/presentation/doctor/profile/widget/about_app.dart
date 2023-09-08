import 'package:flutter/material.dart';

class DoctorAboutWidget extends StatelessWidget {
  const DoctorAboutWidget({super.key});

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
                    'About',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child:  Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16.0),
                      Text(
                        'Welcome to AppointMedic, your trusted platform to connect with patients and offer your healthcare services seamlessly. We are dedicated to making healthcare accessible and efficient for both doctors and patients.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Why Choose AppointMedic',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Expand Your Reach: AppointMedic provides a platform for you to reach a broader patient base. Our patient network is diverse and growing.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Streamlined Booking: We offer a convenient appointment booking system that allows patients to schedule appointments with you at their convenience.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Verified Professionals: Our rigorous verification process ensures that only qualified and trusted healthcare professionals become part of our network.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Seamless Communication: AppointMedic facilitates clear and efficient communication between you and your patients. You\'ll receive timely notifications and reminders for appointments.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Your Expertise Matters',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'We value your expertise and commitment to healthcare. By joining AppointMedic, you become an integral part of our mission to improve healthcare accessibility. Your well-being and professional growth are important to us.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Join Us Today',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Start your journey with AppointMedic and experience a new way of connecting with patients and delivering healthcare services. Together, we can make a positive impact on healthcare delivery.',
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
