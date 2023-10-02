import 'package:appoint_medic/core/color_constants.dart';
import 'package:flutter/material.dart';

class ScreenAbout extends StatelessWidget {
   ScreenAbout({super.key});

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
                    icon:  Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    )),
                 Text(
                  'About',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
            Expanded(
              child: Padding(
                padding:  EdgeInsets.all(15.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Center(
                      child: Text(
                        ' AppointMedic ',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: appBackGround
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          child: Image.asset(
                            'assets/1024.png',
                            fit: BoxFit.cover,
                            height:size.width * 0.30,
                            width: size.width * 0.30,
                          ),
                        ),
                      ),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'Welcome to AppointMedic, your trusted partner in accessing quality healthcare on your terms. At AppointMedic, we are dedicated to revolutionizing the way you connect with healthcare professionals. Our mission is simple: to bridge the gap between patients and doctors seamlessly and efficiently.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'Connecting You to the Best Doctors',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      
                      ),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'AppointMedic empowers you to take control of your health by offering a platform where skilled and certified doctors can register and provide their services. Our rigorous verification process ensures that only the most qualified and trusted healthcare professionals are part of our network. Your well-being is our top priority.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'Your Health, Your Schedule',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'With AppointMedic, you have the flexibility to book appointments at your convenience. Our doctors set their available time slots, allowing you to choose a time that suits you best. Whether it\'s a routine checkup, a specialist consultation, or urgent medical attention, you can find the right healthcare provider and schedule an appointment with ease.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'Seamless Booking and Communication',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'When you make an appointment through AppointMedic, you can rest assured that your booking details are instantly communicated to your chosen doctor. Our platform facilitates clear and efficient communication between patients and healthcare providers. You\'ll receive timely notifications and reminders for your appointments, ensuring a hassle-free healthcare experience.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'Our Vision',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,color: appBackGround
                      ),
                    ),
                     SizedBox(height: 16.0),
                     Text(
                      'At AppointMedic, we envision a future where accessing healthcare is as simple as a few taps on your device. We are committed to continually improving our platform to provide you with the best healthcare experience possible. Your feedback and trust drive us to innovate and enhance our services.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                     SizedBox(height: 16.0),
                 
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
