import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'patient_edit_profile_event.dart';
part 'patient_edit_profile_state.dart';

class PatientEditProfileBloc
    extends Bloc<PatientEditProfileEvent, PatientEditProfileState> {
  final CreateServiceImpl createServiceImpl;
  PatientEditProfileBloc(this.createServiceImpl)
      : super(PatientEditProfileInitial()) {
    on<PatientProfileEditCall>((event, emit) async {
      emit(PatientProfileEditLoading());

      final response = await createServiceImpl.onboardingPatient(
          patientForm: event.patientForm);

      if (response.isEmpty) {
        emit(PatientProfileEditSuccess());
      } else {
        emit(PatientProfileEditFailed(response));
      }
    });

    on<ClearPatientEditProfileProcess>((event, emit) {
      emit(PatientEditProfileInitial());
    });
  }
}
