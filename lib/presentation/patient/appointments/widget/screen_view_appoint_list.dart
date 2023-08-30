import 'dart:developer';

import 'package:appoint_medic/application/view_appointments_screen/bloc/view_appointments_patient_side_bloc.dart';
import 'package:appoint_medic/presentation/patient/appointments/widget/appoint_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScreenTodayAppointmentPatient extends StatelessWidget {
  const ScreenTodayAppointmentPatient(
      {super.key, required this.size, required this.status});

  final Size size;
  final String status;

  @override
  Widget build(BuildContext context) {
    //---------------------------------------------------------------------------bloc call for fetching appointments
    context
        .read<ViewAppointmentsPatientSideBloc>()
        .add(ViewAllAppoinmentsPatientCall(status: status));
//-----------------------------------------------------------------------------------------------
    return BlocBuilder<ViewAppointmentsPatientSideBloc,
        ViewAppointmentsPatientSideState>(
      builder: (context, state) {
        if (state is AllPatientAppointmentsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          );
        } else if (state is AllPatientAppointmentsFailed) {
          //-------------------------------show error
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Offline'),
                const SizedBox(
                  height: 5,
                ),
                IconButton(
                    onPressed: () {
                      //------------------------------------------------refresh function
                      context
                          .read<ViewAppointmentsPatientSideBloc>()
                          .add(ViewAllAppoinmentsPatientCall(status: status));
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
          );
        } else if (state is AllPatientAppointmentsSucess) {
          //----------------------------------------------------------list empty
          if (state.availableAppoints.appointments!.isEmpty) {
            return const Center(
              child: Text('No Appointments'),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                //----------------------------data
                String? startTime =
                    state.availableAppoints.appointments![index].startTime!;

                String? endTime =
                    state.availableAppoints.appointments![index].endTime!;
                String? doctorName = state
                    .availableAppoints.appointments![index].doctor!.fullName!;
                String? formatedDate;
                String? speciality = state
                    .availableAppoints.appointments![index].speciality?.name;
                String? doctImage = state.availableAppoints.appointments![index]
                    .doctor!.profilePicture!.secureUrl!;
                String? bookingstatus = state.availableAppoints
                        .appointments![index].isApprovedByDoctor!
                    ? 'Approved'
                    : 'Pending';
                if (state.availableAppoints.appointments![index].selectedDate ==
                    null) {
                  formatedDate = 'Na';
                } else {
                  formatedDate = DateFormat('dd MMM yyyy').format(state
                      .availableAppoints.appointments![index].selectedDate!);
                }
                return AppointmentListTileWidget(
                  size: size,
                  date: formatedDate,
                  doctorname: doctorName,
                  startTime: startTime,
                  endTime: endTime,
                  speciality: speciality,
                  doctImageUrl: doctImage,
                  bookingStatus: bookingstatus,
                  doctorID:
                      state.availableAppoints.appointments![index].doctorId!,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: state.availableAppoints.appointments!.length);
        } else {
          return const Center(
            child: Text('No Appointments '),
          );
        }
      },
    );
  }
}
