import 'package:appoint_medic/domain/models/onboardingDoctor/doctor_onb_model.dart';
import 'package:appoint_medic/domain/models/onboardingPatient/patient_onb_model.dart';
import 'package:appoint_medic/domain/registeration.dart';
import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final CreateServiceImpl createAccountService;
  OnBoardingBloc(this.createAccountService) : super(OnBoardingInitial()) {
    on<OnBoardPatientEvent>((event, emit) async {
      emit(OnBoardingLoading());

      final (error, response) = await createAccountService.onboardingPatient(
          token: event.token, patientForm: event.patientform);

      if (error.isEmpty) {
        emit(OnBordingSuccess());
      } else {
        emit(OnBordingFailure(error: error));
      }
    });

    on<OnBoardDoctorEvent>((event, emit) async {
      emit(OnBoardingLoading());

      final (error, response) = await createAccountService.onboardingDoctor(
          token: event.token, doctorForm: event.doctorform);

      if (error.isEmpty) {
        emit(OnBordingSuccess());
      } else {
        emit(OnBordingFailure(error: error));
      }
    });

    on<ClearOnboardingState>((event, emit) {
      emit(OnBoardingInitial());
    });
  }
}
