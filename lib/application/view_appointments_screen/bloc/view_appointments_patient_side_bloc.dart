import 'package:appoint_medic/domain/response_models/view_appointments_page/view_appointment_patient_side/view_appointment_patient_side_bloc.dart';
import 'package:appoint_medic/infrastructure/view_appointments_patient_side/view_appointments_pat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'view_appointments_patient_side_event.dart';
part 'view_appointments_patient_side_state.dart';

class ViewAppointmentsPatientSideBloc extends Bloc<
    ViewAppointmentsPatientSideEvent, ViewAppointmentsPatientSideState> {
  final ViewAppointmentsPatientSideService _viewAppointmentsPatientSideService;
  //----------------------------------------------------------------------------service object
  ViewAppointmentsPatientSideBloc(this._viewAppointmentsPatientSideService)
      : super(ViewAppointmentsPatientSideInitial()) {
    on<ViewAllAppoinmentsPatientCall>((event, emit) async {
      emit(AllPatientAppointmentsLoading());

      final (error, response) = await _viewAppointmentsPatientSideService
          .getAllAppointmentsPatient(status: event.status);

      if (error.isEmpty) {
        emit(AllPatientAppointmentsSucess(availableAppoints: response!));
      } else {
        emit(AllPatientAppointmentsFailed(
            error: 'Error fetching appointment list'));
      }
    });
  }
}
