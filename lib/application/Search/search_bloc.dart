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
        log('api call sucess');
      } else {
        emit(SearchFailure(error));
        log('api call failed');
      }
    });
  }
}
