import 'dart:developer';

import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/infrastructure/search_screen/search_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_by_category_event.dart';
part 'search_by_category_state.dart';

class SearchByCategoryBloc
    extends Bloc<SearchByCategoryEvent, SearchByCategoryState> {
  final SearchService searchService;

  SearchByCategoryBloc(this.searchService) : super(SearchByCategoryInitial()) {
    on<SearchDoctorBySpeciality>((event, emit) async {
      emit(SearchByCategoryloading());
      log('new catergoty bloc');

//log('bloc ${event.gender} , ${event.name}, , ${event.speciality}');

      final (error, response) = await searchService.searchByFilter(
          name: '', gender: '', speciality: event.specialityID);

      // log(response.toString());

      if (error.isEmpty) {
        emit(SearchByCategorySucess(response!.doctors!));
        // log('api call  filtersucess');
      } else {
        emit(SearchByCategoryFailure(error));

        // log(error);
        // log('api call filter failed bloc');
      }
    });
  }
}
