import 'package:appoint_medic/presentation/doctor/all_appointments/widgets/all_appoint.dart';
import 'package:appoint_medic/presentation/doctor/all_appointments/widgets/approved.dart';
import 'package:appoint_medic/presentation/doctor/all_appointments/widgets/cancelled.dart';
import 'package:appoint_medic/presentation/doctor/all_appointments/widgets/pending.dart';
import 'package:flutter/material.dart';

class ScreenAllAppointments extends StatelessWidget {
  const ScreenAllAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                height: size.height * 0.07,
                child: const Center(
                  child: Text(
                    'Appointments',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    //height: 40,
                    height: size.height * 0.06,

                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TabBar(
                          physics: NeverScrollableScrollPhysics(),
                          labelStyle: TextStyle(
                            fontSize: size.width * 0.03,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color: Colors.blue.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tabs: const [
                            Tab(
                              iconMargin: EdgeInsets.only(),
                              child: Text(
                                'Approved',
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
                                'Cancelled ',
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
                height: 5,
              ),
              Container(
                height: size.height * 0.7,
                // color: Colors.amber,
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15),
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ScreenApprovedAppoint(),
                        ScreenPendingAppoint(),
                        ScreenCancelledAppoint(),
                        ScreenAllAppoint()
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
