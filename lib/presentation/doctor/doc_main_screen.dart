import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/presentation/doctor/all_appointments/all_appointments.dart';
import 'package:appoint_medic/presentation/doctor/avaliable_times/screen_avalibale_time.dart';
import 'package:appoint_medic/presentation/doctor/home/screen_doct_Home.dart';
import 'package:appoint_medic/presentation/doctor/messages/doct_message_screen.dart';
import 'package:appoint_medic/presentation/doctor/profile/Screen_doc_profile.dart';
import 'package:flutter/material.dart';


class DoctorScreenMain extends StatelessWidget {
  const DoctorScreenMain({
    super.key, required this.name, 
  });

    final String name;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> doctPagesNotifier = ValueNotifier(0);
    final size = MediaQuery.of(context).size;

    final _pages = [
      ScreenDoctHome(name: name,),
      ScreenAllAppointments(),
      ScreenAvailableTime(),
      ScreemDoctMessage(),
      ScreenDocProfile()
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
        body: ValueListenableBuilder(
          valueListenable: doctPagesNotifier,
          builder: (context, pageIndex, child) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _pages[pageIndex],
                Positioned(
                  bottom: 20,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              doctPagesNotifier.value = 0;
                            },
                            icon: const Icon(
                              Icons.home,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              doctPagesNotifier.value = 1;
                            },
                            icon: const Icon(
                              Icons.edit_calendar_outlined,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              doctPagesNotifier.value = 2;
                            },
                            icon: const Icon(
                              Icons.access_time,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              doctPagesNotifier.value = 3;
                            },
                            icon: const Icon(
                              Icons.message,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              doctPagesNotifier.value = 4;
                            },
                            icon: const Icon(
                              Icons.person_2_rounded,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


















//  Positioned(
//                   bottom: 20,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(10)),
//                     height: 50,
//                     width: size.width * 0.8,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               doctPagesNotifier.value = 0;
//                             },
//                             icon: const Icon(
//                               Icons.home,
//                               color: Colors.white,
//                             )),
//                         IconButton(
//                             onPressed: () {
//                               doctPagesNotifier.value = 1;
//                             },
//                             icon: const Icon(
//                               Icons.edit_calendar_outlined,
//                               color: Colors.white,
//                             )),
//                         IconButton(
//                             onPressed: () {
//                               doctPagesNotifier.value = 2;
//                             },
//                             icon: const Icon(
//                               Icons.message,
//                               color: Colors.white,
//                             )),
//                         IconButton(
//                             onPressed: () {
//                               doctPagesNotifier.value = 3;
//                             },
//                             icon: const Icon(
//                               Icons.person_2_rounded,
//                               color: Colors.white,
//                             ))
//                       ],
//                     ),
//                   ),
//                 )