import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:flutter/material.dart';

class ScreenBooking extends StatelessWidget {
  const ScreenBooking({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //----------------------------------------------------appbar
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
                  const Expanded(
                      child: Text(
                    'Appointment',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
            //------------------------------------------->>>appbar

            //doctor details
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15, bottom: 15, top: 20),
              child: Text(
                'Doctor details',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                height: size.height * 0.20,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: size.height * 0.16,
                          width: 150,

                          child:  Image.network(
                            doctor.profilePicture?.secureUrl ?? '' ,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          
                            errorBuilder: (context, error, stackTrace) {
                              if (doctor.gender == 'female') {
                                return Image.asset(
                                  'assets/female_doctor.png',
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return Image.asset(
                                  'assets/doctor_male.png',
                                  fit: BoxFit.cover,
                                );
                              }
                            }
                          ),
                          // color: Colors.green,
                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          //     image: DecorationImage(fit: BoxFit.cover,
                          //         // image: NetworkImage(
                          //         //     doctor.profilePicture!.secureUrl!)
                          //         image: Image.network('src')
                          //         )

                          //         ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        // color: Colors.amber,
                        height: size.height * 0.16,
                        width: 170,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr.${doctor.fullName!}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              doctor.speciality!.name!,
                            ),
                            const SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.chat_rounded,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(Icons.videocam)
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Payment',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${doctor.speciality!.fees!} Rs',
                                  style: const TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
