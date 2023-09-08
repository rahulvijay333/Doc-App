import 'dart:developer';

import 'package:appoint_medic/application/doctor%20profile/appointments_section/bloc/home_appointment_today_bloc.dart';
import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/presentation/doctor/home/widget/appmtns_tile.dart';
import 'package:appoint_medic/presentation/doctor/home/widget/icon_text.dart';
import 'package:appoint_medic/presentation/doctor/home/widget/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenDoctHome extends StatelessWidget {
  const ScreenDoctHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<HomeAppointmentTodayBloc>().add(ViewTodaysAppointments());
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //--------------------------------blue container
          Container(
            width: size.width,
            height: size.height * 0.18,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                // color: Colors.amber,
                color: Color.fromRGBO(0, 150, 255, 10)),
            child: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
              builder: (context, state) {
                if (state is DoctorProfileLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  );
                }

                if (state is DoctorProfileSuccess) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8, top: 10, right: 8, bottom: 8),
                    //------------------------------------------------------name details
                    child: ProfileTileCustom(
                      size: size,
                      doctorDetails: state.doctDetails,
                    ),
                  );
                }
                if (state is DoctorPrifleFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Offline',
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              //------------------------------refresh

                              context
                                  .read<DoctorProfileBloc>()
                                  .add(GetDoctorProfileCall());
                            },
                            icon: const Icon(
                              Icons.refresh_outlined,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  );
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Offline',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {
                            //------------------------------refresh

                            context
                                .read<DoctorProfileBloc>()
                                .add(GetDoctorProfileCall());
                          },
                          icon: const Icon(
                            Icons.refresh_outlined,
                            color: Colors.white,
                          ))
                    ],
                  ),
                );
              },
            ),
          ),
          //----------------------------------------------container 2 - appointments

          Container(
              width: size.width,
              height: size.height * 0.65,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 1),
                // color: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Appointments',
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Expanded(
                      child: BlocBuilder<HomeAppointmentTodayBloc,
                          HomeAppointmentTodayState>(
                        builder: (context, state) {
                          if (state is TodayAppointmentLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            );
                          } else if (state is TodayAppointmentSuccess) {
                            if (state.appointmentList.isEmpty) {
                              return const Center(
                                child: Text('No Appointment'),
                              );
                            }

                            return ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ApointTodayTileWidget(
                                      size: size,
                                      patientName: state.appointmentList[index]
                                          .patient!.fullName!,
                                      imgUrl: state.appointmentList[index]
                                          .patient!.profilePicture?.secureUrl,
                                      date: state
                                          .appointmentList[index].selectedDate!,
                                      startTime: state
                                          .appointmentList[index].startTime!,
                                      endTime:
                                          state.appointmentList[index].endTime!,
                                      patientID: state
                                          .appointmentList[index].patientId!);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: state.appointmentList.length);
                          } else if (state is TodayAppointmentFailed) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Error occured'),
                                  TextButton(
                                      onPressed: () {
                                        //-------------------------------------resfresh
                                        context
                                            .read<HomeAppointmentTodayBloc>()
                                            .add(ViewTodaysAppointments());
                                      },
                                      child: Icon(Icons.refresh))
                                ],
                              ),
                            );
                          }

                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Error occured'),
                                TextButton(
                                    onPressed: () {
                                      //-------------------------------------resfresh
                                      context
                                          .read<HomeAppointmentTodayBloc>()
                                          .add(ViewTodaysAppointments());
                                    },
                                    child: Icon(Icons.refresh))
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
