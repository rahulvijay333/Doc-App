import 'dart:developer';

import 'package:appoint_medic/application/view_appointments_screen/bloc/view_appointments_patient_side_bloc.dart';
import 'package:appoint_medic/presentation/patient/appointments/widget/screen_view_appoint_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScreenAppointments extends StatelessWidget {
  const ScreenAppointments({super.key});

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    log((size.width * 0.02).toString());

    return DefaultTabController(
      length: 3,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        // decoration: backgroundDecoration,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
              child: const Center(
                child: Text(
                  'Appointments',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.blue.withOpacity(0.1),
                  //height: 40,
                  height: size.height * 0.06,

                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TabBar(
                        labelStyle: TextStyle(
                          fontSize: size.width * 0.03,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: Colors.blue.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tabs: const [
                          Tab(
                            child: Text(
                              'Today',
                            ),
                          ),
                          Tab(
                            //text: 'today',
                            child: Text(
                              'Upcoming',
                            ),
                          ),
                          Tab(
                            //text: 'today',
                            child: Text(
                              'All ',
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: TabBarView(children: [
                  ScreenTodayAppointmentPatient(
                    size: size,
                    status: 'today',
                  ),
                  ScreenTodayAppointmentPatient(
                    size: size,
                    status: 'upcoming',
                  ),
                  ScreenTodayAppointmentPatient(size: size, status: '')
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

