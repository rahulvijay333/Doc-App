import 'dart:developer';

import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/infrastructure/search_screen/search_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService searchService;

  SearchBloc(this.searchService) : super(SearchInitial()) {
    on<ShowAllDoctorList>((event, emit) async {
      emit(SearchLoading());

      final (error, apiResponse) = await searchService.showAllDoctorList();

      if (error.isEmpty) {
        emit(SearchSucess(apiResponse!.doctors!));
        log('api call show all sucess');
      } else {
        emit(SearchFailure(error));
        log('api call failed bloc');
      }
    });

    on<SearchByFilter>((event, emit) async {
      emit(SearchFilterLoading());

      log('bloc ${event.gender} , ${event.name}, , ${event.speciality}');

      final (error, response) = await searchService.searchByFilter(
          name: event.name, gender: event.gender, speciality: event.speciality);

      log(response.toString());

      if (error.isEmpty) {
        emit(SearchFilterSuccess(response!.doctors!));
        // log('api call  filtersucess');
      } else {
        emit(SearchFilterFailure(error));

        log(error);
        log('api call filter failed bloc');
      }
    });

    on<SearchByName>((event, emit) async {
      emit(SearchNameLoading());

      log('bloc, ${event.name},}');

      final (error, response) =
          await searchService.searchByFilter(name: event.name);

      log(response.toString());

      if (error.isEmpty) {
        emit(SearchNameSucess(response!.doctors!));
        // log('api call  filtersucess');
      } else {
        emit(SearchNameFailure(error));

        log(error);
        log('api call filter failed bloc');
      }
    });
  }
}
