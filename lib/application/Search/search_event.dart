part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class ShowAllDoctorList extends SearchEvent {}

class SearchByName extends SearchEvent {
  final String name;

  SearchByName(this.name);
}

class SearchByFilter extends SearchEvent {
  final String? name;
  final String? gender;
  final String? speciality;

  SearchByFilter({this.name, this.gender, this.speciality});
}
