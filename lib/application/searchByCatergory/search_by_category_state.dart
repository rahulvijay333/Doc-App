part of 'search_by_category_bloc.dart';

@immutable
abstract class SearchByCategoryState {}

class SearchByCategoryInitial extends SearchByCategoryState {}

class SearchByCategoryloading extends SearchByCategoryState {}

class SearchByCategorySucess extends SearchByCategoryState {
  final List<Doctor> searchCatResults;

  SearchByCategorySucess(this.searchCatResults);
}

class SearchByCategoryFailure extends SearchByCategoryState {
  final String errorMessage;

  SearchByCategoryFailure(this.errorMessage);
}
