import 'package:appoint_medic/infrastructure/view_appointments_doctor_service/appointments_fetch_service.dart';
import 'package:bloc/bloc.dart';

import '../../../../domain/response_models/view_appointments_page/doctor_side/view_all_app_doct_side_model/appointment.dart';

part 'home_appointment_today_event.dart';
part 'home_appointment_today_state.dart';

class HomeAppointmentTodayBloc
    extends Bloc<HomeAppointmentTodayEvent, HomeAppointmentTodayState> {
  final ViewAppointmentsDoctSideService viewApptsDoctSideService;
  HomeAppointmentTodayBloc(this.viewApptsDoctSideService)
      : super(HomeAppointmentTodayInitial()) {
    on<ViewTodaysAppointments>((event, emit) async {
      List<Appointment> appointmentList = [];

      emit(TodayAppointmentLoading());

      final (error, response) = await viewApptsDoctSideService
          .getAllAppointmentsDoctSide(status: 'today');

      if (error.isEmpty) {
        if (response!.appointments!.isEmpty) {
          emit(TodayAppointmentSuccess(appointmentList: []));
        } else {
          for (var app in response.appointments!) {
            if (app.isApprovedByDoctor == true) {
              appointmentList.add(app);
            }
          }

          emit(TodayAppointmentSuccess(appointmentList: appointmentList));
        }
      } else {
        emit(TodayAppointmentFailed(error: error));
      }
    });
  }
}
