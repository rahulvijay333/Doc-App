import 'dart:developer';

import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/patient/appointments/widget/tab_indicator_color.dart';
import 'package:flutter/material.dart';

class ScreenAppointments extends StatelessWidget {
  const ScreenAppointments({super.key});

  //final TabController _tabController = TabController(length: 2, vsync: this);

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
                              'Upcoming',
                            ),
                          ),
                          Tab(
                            //text: 'today',
                            child: Text(
                              'Completed',
                            ),
                          ),
                          Tab(
                            //text: 'today',
                            child: Text(
                              'Cancelled',
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
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              height: size.height * 0.125,
                              color: Colors.blue.withOpacity(0.1),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 15, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          // color: Colors.red,
                                          width: size.width * 0.4,
                                          child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Dr.Name',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text('Speciality')
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: const CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                                'assets/doctor_sample.png'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('24/02/2023'),
                                      Text('Time'),
                                      Text('Confirmed')
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: 10),
                  const Text('completed'),
                  const Text('Cancelled'),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
