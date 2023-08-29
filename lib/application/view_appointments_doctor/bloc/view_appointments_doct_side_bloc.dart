import 'dart:developer';

import 'package:appoint_medic/domain/response_models/view_appointments_page/doctor_side/view_all_app_doct_side_model/appointment.dart';
import 'package:appoint_medic/infrastructure/view_appointments_doctor_service/appointments_fetch_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'view_appointments_doct_side_event.dart';
part 'view_appointments_doct_side_state.dart';

class ViewAppointmentsDoctSideBloc
    extends Bloc<ViewAppointmentsDoctSideEvent, ViewAppointmentsDoctSideState> {
  final ViewAppointmentsDoctSideService viewApptsDoctSideService;
  ViewAppointmentsDoctSideBloc(this.viewApptsDoctSideService)
      : super(ViewAppointmentsDoctSideInitial()) {
    on<ViewApptDoctorSideCall>((event, emit) async {
      emit(DoctorSideApptsLoading());

      final (error, response) = await viewApptsDoctSideService
          .getAllAppointmentsDoctSide(status: event.status);

      if (error.isEmpty) {
        if (response!.appointments!.isEmpty) {
          emit(DoctorSideApptsSuccess(appointmentList: []));
        } else {
          emit(DoctorSideApptsSuccess(appointmentList: response.appointments!));
        }
      } else {
        emit(DoctSideApptsFailed(error: error));
      }
    });
//-----------------------------------------------------------------approvee booking
    on<ApproveBookingCall>((event, emit) async {
      final error = await viewApptsDoctSideService.approveBooking(
          bookingID: event.bookingID);

      if (error.isEmpty) {
        add(ViewApptDoctorSideCall(status: 'pending'));
      } else {}
    });

    //-----------------------------------------------------------------cancel booking

    on<CancelBookingCall>((event, emit) async {
      final error = await viewApptsDoctSideService.cancelBooking(
          bookingID: event.bookingID);

      if (error.isEmpty) {
        add(ViewApptDoctorSideCall(status: 'pending'));
      }
    });
  }
}
