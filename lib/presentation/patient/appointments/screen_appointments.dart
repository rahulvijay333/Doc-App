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
      length: 5,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: backgroundDecoration,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'All Appointments',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  //height: 40,
                  height: size.height * 0.05,

                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TabBar(
                        labelStyle: TextStyle(
                          fontSize: size.width * 0.02,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tabs: const [
                          Tab(
                            child: Text(
                              'Today',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Upcoming',
                            ),
                          ),
                          Tab(
                            //text: 'today',
                            child: Text(
                              'Pending',
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(children: [
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              height: size.height * 0.12,
                              color: Colors.white.withOpacity(0.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                    ),
                                    title: Text('Dr. Doctor Name'),
                                    subtitle: Text('speciality'),
                                    trailing: IconButton(
                                        onPressed: () {
                                          //----------------------------------------message option
                                        },
                                        icon: Icon(Icons.message)),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Date: 24/5/23 '),
                                        Text('Time : 4.00pm')
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: 10),
                  Text('upcming'),
                  Text('pending'),
                  Text('Cancelled'),
                  Text('Cancelled'),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
