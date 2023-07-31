part of 'search_by_category_bloc.dart';

@immutable
abstract class SearchByCategoryEvent {}

class SearchDoctorBySpeciality extends SearchByCategoryEvent {
  final String specialityID;

  SearchDoctorBySpeciality(this.specialityID);
}
