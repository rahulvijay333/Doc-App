import 'dart:developer';

import 'package:appoint_medic/domain/response_models/view_appointments_page/view_appointment_patient_side/appointment.dart';
import 'package:appoint_medic/infrastructure/view_appointments_patient_side/view_appointments_pat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_today_appointments_event.dart';
part 'home_today_appointments_state.dart';

class HomeTodayAppointmentsBloc
    extends Bloc<HomeTodayAppointmentsEvent, HomeTodayAppointmentsState> {
  final ViewAppointmentsPatientSideService _viewAppointmentsPatientSideService;
  HomeTodayAppointmentsBloc(this._viewAppointmentsPatientSideService)
      : super(HomeTodayAppointmentsInitial()) {
    on<GetTodayAppointmentPatientCall>((event, emit) async {
      emit(HomeTodayAppointsLoading());
      List<Appointment> appointmentList = [];
      final (error, response) = await _viewAppointmentsPatientSideService
          .getAllAppointmentsPatient(status: 'today');

      if (error.isEmpty) {
        if (response!.appointments!.isEmpty) {
          emit(HomeTodayAppointsSuccess(appointmentList: []));
        } else {
          for (var appointment in response.appointments!) {
            if (appointment.isApprovedByDoctor == true) {
              appointmentList.add(appointment);
            }
          }

          emit(HomeTodayAppointsSuccess(appointmentList: appointmentList));
        }
      } else {
        log('error in HomeTodayAppointmentsBloc ');
        emit(HomeTodayAppointsFailure(error: 'Error happened fetching  bloc'));
      }
    });
  }
}
