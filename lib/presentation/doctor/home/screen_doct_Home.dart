import 'dart:developer';

import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/presentation/doctor/home/widget/icon_text.dart';
import 'package:flutter/material.dart';

class ScreenDoctHome extends StatelessWidget {
  const ScreenDoctHome({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log((size.height * 0.05).toString());

    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //--------------------------------blue container
              Container(
                width: size.width,
                height: size.height * 0.35,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30)),
                    color: Color.fromRGBO(0, 150, 255, 10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, top: 25, right: 8, bottom: 8),
                      //------------------------------------------------------name details
                      child: Container(
                        // color: Colors.red,
                        width: size.width,
                        height: size.height * 0.3 * 0.50,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage('assets/doctor.png'),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                                height: size.height * 0.3 * 0.40,
                                width: size.width * 0.6,
                                //  color: Colors.green,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Welcome,',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        )),
                                    SizedBox(
                                        height:
                                            size.height * 0.3 * 0.40 * 0.05),
                                    Text('Dr.$name',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                        height:
                                            size.height * 0.3 * 0.40 * 0.02),
                                    const Text('MBBS, MDS',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                    //------------------------------------------icon section
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        // color: Colors.green,
                        height: size.height * 0.3 * 0.5,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatarWithWidgets(),
                                const Text(
                                  'Total Patients',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatarWithWidgets(),
                                const Text(
                                  'Total Patients',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatarWithWidgets(),
                                const Text(
                                  'Total Patients',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //----------------------------------------------container 2
              Expanded(
                child: Container(
                  width: size.width,
                  // height: size.height * 0.05,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 150, 255, 10)),
                ),
              ),
            ],
          ),
          Positioned(
            top: size.height * 0.35,
            bottom: 0,
            left: 0,
            child: Container(
                width: size.width,
                height: size.height * 0.30,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30)),
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Appointments',
                        style: TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
