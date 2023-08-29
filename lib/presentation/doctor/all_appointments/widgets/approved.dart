import 'package:appoint_medic/application/view_appointments_doctor/bloc/view_appointments_doct_side_bloc.dart';
import 'package:appoint_medic/presentation/doctor/all_appointments/widgets/widget/apptn_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenApprovedAppoint extends StatelessWidget {
  const ScreenApprovedAppoint({super.key});

  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------api call
    context
        .read<ViewAppointmentsDoctSideBloc>()
        .add(ViewApptDoctorSideCall(status: 'approved'));
    //----------------------------<<<----------------------------
    return BlocBuilder<ViewAppointmentsDoctSideBloc,
        ViewAppointmentsDoctSideState>(
      builder: (context, state) {
        if (state is DoctorSideApptsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          );
        }
        if (state is DoctorSideApptsSuccess) {
          if (state.appointmentList.isEmpty) {
            return const Center(
              child: Text('No Appointments'),
            );
          }

          return ListView.separated(
              itemBuilder: (context, index) {
                final stateShort = state.appointmentList[index];

                return AppointmentTileCustom(
                  patientName: stateShort.patient!.fullName!,
                  emailID: stateShort.patient!.email!,
                  date: state.appointmentList[index].selectedDate,
                  startTime: stateShort.startTime!,
                  endTime: stateShort.endTime!,
                  isDoctorApproved: stateShort.isApprovedByDoctor!,
                  patientImage: stateShort.patient!.profilePicture!.secureUrl!,
                  bookID: state.appointmentList[index].id!,
                  isCancelled: state.appointmentList[index].isCancelled!,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: state.appointmentList.length);
        }

        return const Center(
          child: Text('No Appointments'),
        );
      },
    );
  }
}
