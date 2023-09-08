
import 'package:appoint_medic/infrastructure/doctor%20profile/doctor_profile_service.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/models/doctor profile/doctor_profile_model/doctor.dart';

part 'doctor_profile_event.dart';
part 'doctor_profile_state.dart';

class DoctorProfileBloc extends Bloc<DoctorProfileEvent, DoctorProfileState> {
  final DoctorProfileService doctorProfileService;
  DoctorProfileBloc(this.doctorProfileService) : super(DoctorProfileInitial()) {
    on<GetDoctorProfileCall>((event, emit) async {
      emit(DoctorProfileLoading());

      final (error, response) = await doctorProfileService.getDoctorProfile();

      if (error.isEmpty) {
      
        emit(DoctorProfileSuccess(doctDetails: response!.doctor!));
      } else {
        emit(DoctorPrifleFailure('Error happened , '));
      }
    });

    on<ClearDoctorProfileCall>((event, emit) {
      emit(DoctorProfileInitial());
    });
  }
}
