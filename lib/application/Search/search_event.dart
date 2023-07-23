part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class ShowAllDoctorList extends SearchEvent {}

class SearchByName extends SearchEvent {
  final String name;

  SearchByName(this.name);
}
