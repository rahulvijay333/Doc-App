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
