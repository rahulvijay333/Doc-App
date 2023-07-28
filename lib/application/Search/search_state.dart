part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSucess extends SearchState {
  final List<Doctor> doctorList;

  SearchSucess(this.doctorList);
}

class SearchFailure extends SearchState {
  final String errorName;

  SearchFailure(this.errorName);
}

class SearchFilterLoading extends SearchState {}

class SearchFilterSuccess extends SearchState {
  final List<Doctor> searchFilterResults;

  SearchFilterSuccess(this.searchFilterResults);
}

class SearchFilterFailure extends SearchState {
  final String errorFilterMessage;

  SearchFilterFailure(this.errorFilterMessage);
}

class SearchNameLoading extends SearchState {}

class SearchNameSucess extends SearchState {
  final List<Doctor> searchNameResults;

  SearchNameSucess(this.searchNameResults);
}

class SearchNameFailure extends SearchState {
  final String nameError;

  SearchNameFailure(this.nameError);
}
