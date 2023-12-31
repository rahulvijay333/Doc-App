import 'dart:developer';

import 'package:appoint_medic/presentation/patient/appointments/widget/screen_view_appoint_list.dart';

import 'package:flutter/material.dart';

import '../../../core/color_constants.dart';


class ScreenAppointments extends StatelessWidget {
  const ScreenAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
 

    return DefaultTabController(
      length: 3,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        // decoration: backgroundDecoration,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                child:  Center(
                  child: Text(
                    'Appointments',
                    style: TextStyle(
                        fontSize: size.width * 0.055,
                        color: appBackGround,
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
                    color: appBackGround.withOpacity(0.1),
                    //height: 40,
                    height: 50,

                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          labelStyle: TextStyle(
                            fontSize: size.width * 0.025,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color:  appBackGround.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tabs: const [
                            Tab(
                              iconMargin: EdgeInsets.only(),
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
              Container(
                height: size.height * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
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
      ),
    );
  }
}
