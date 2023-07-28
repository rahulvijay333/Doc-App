import 'package:appoint_medic/domain/response_models/get_specialities_response/speciality.dart';
import 'package:appoint_medic/infrastructure/specialities/get_speciality_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'speciality_event.dart';
part 'speciality_state.dart';

class SpecialityBloc extends Bloc<SpecialityEvent, SpecialityState> {
  final SpecialityService specialityService;

  SpecialityBloc(this.specialityService) : super(SpecialityInitial()) {
    on<DisplaySpecialityHome>((event, emit) async {
      emit(SpecialityLoading());

      final (error, response) = await specialityService.getSpeciality();

      if (error.isEmpty) {
        emit(SpecialitySucess(response!.specialities!));
      } else {
        emit(SpecialityFailure(error));
      }
    });
  }
}
