import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/presentation/patient/booking/const/text.dart';
import 'package:appoint_medic/presentation/patient/booking/screen_booking.dart';
import 'package:flutter/material.dart';

class ScreenViewDoctorProfileBook extends StatelessWidget {
  const ScreenViewDoctorProfileBook({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    //log(doctor.gender!);
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.07,
                color: Colors.blue,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          //-------------------------------------------pop function

                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                    const Text(
                      'View Profile',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  height: size.height * 0.35,
                  width: size.width,
                  color: Colors.blue.withOpacity(0.40),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          //-------------------------------------------------------------------profile image
                          // color: Colors.amber,
                          width: size.width * 0.50,
                          height: size.height * 0.30 * 0.80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue.shade100,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: doctor.profilePicture == null
                                      ? doctor.gender == 'female'
                                          ? const AssetImage(
                                              'assets/female_doctor.png')
                                          : const AssetImage(
                                              'assets/doctor_male.png')
                                      : NetworkImage(
                                              doctor.profilePicture!.secureUrl!)
                                          as ImageProvider)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white.withOpacity(0.5),
                              child: const Text('+12 yrs'),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white.withOpacity(0.5),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('5'),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 255, 150, 59),
                                  )
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white.withOpacity(0.5),
                              child: Text('+150k'),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr ${doctor.fullName}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Speciality : ${doctor.speciality!.name!}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Address : ${doctor.address!.houseName},${doctor.address!.city}, ${doctor.address!.state}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Qualification : ${doctor.qualification?.toUpperCase()}'),
                  ],
                ),
              ),
              //-----------------------------------------------
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Container(
                    color: Colors.blue.withOpacity(0.1),
                    child: TabBar(labelColor: Colors.blue, tabs: [
                      Tab(
                        text: 'About',
                      ),
                      Tab(
                        text: 'Reviews',
                      )
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  // color: Colors.blue.withOpacity(0.2),
                  height: 150,
                  child: TabBarView(children: [
                    Text(
                      aboutSection,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    Center(
                      child: Text('Reviews'),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ScreenBooking(doctor: doctor);
                          },
                        ));
                      },
                      child: Text('Book Appointment'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
