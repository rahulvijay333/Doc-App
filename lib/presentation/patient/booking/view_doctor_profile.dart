import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/presentation/patient/booking/const/text.dart';
import 'package:appoint_medic/presentation/patient/booking/screen_booking.dart';
import 'package:flutter/material.dart';

class ScreenViewDoctorProfileBook extends StatelessWidget {
  const ScreenViewDoctorProfileBook({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
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
                  Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const ScrollPhysics(),
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //-------------------------------------------------------------------profile image

                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.blue.shade100,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: doctor.profilePicture == null
                                ? doctor.gender == 'female'
                                    ? const AssetImage(
                                        'assets/female_doctor.png')
                                    : const AssetImage('assets/doctor_male.png')
                                : NetworkImage(
                                        doctor.profilePicture!.secureUrl!)
                                    as ImageProvider)),
                  ),
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
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Container(
                        color: Colors.blue.withOpacity(0.1),
                        child: const TabBar(labelColor: Colors.blue, tabs: [
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
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Container(
                      // color: Colors.red,
                      height: 150,
                      child: TabBarView(children: [
                        Center(
                          child: Text(
                            // aboutSection,
                            'About Section',

                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        const Center(
                          child: Text('Reviews(comming soon)'),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 40,
                        width: size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ScreenBooking(doctor: doctor);
                              },
                            ));
                          },
                          child: Text(
                            'Book',
                            style: TextStyle(fontSize: size.width * 0.4 * 0.08),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
