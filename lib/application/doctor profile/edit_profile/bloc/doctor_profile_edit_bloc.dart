import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'doctor_profile_edit_event.dart';
part 'doctor_profile_edit_state.dart';

class DoctorProfileEditBloc
    extends Bloc<DoctorProfileEditEvent, DoctorProfileEditState> {
  final CreateServiceImpl createServiceImpl;
  DoctorProfileEditBloc(this.createServiceImpl)
      : super(DoctorProfileEditInitial()) {
    on<DoctorProfileEditCall>((event, emit) async {
      emit(DoctorProfileEditLoading());

      final response = await createServiceImpl.editProfileDoctor(
          doctorForm: event.doctorForm);

      if (response.isEmpty) {
        emit(DoctorProfileEditSuccess());
      } else {
        emit(DoctorProfileEditFailed(response));
      }
    });

    on<ClearDoctorEditProcessCall>((event, emit) {
      emit(DoctorProfileEditInitial());
    });
  }
}
