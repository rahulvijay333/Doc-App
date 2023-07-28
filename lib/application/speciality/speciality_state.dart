part of 'speciality_bloc.dart';

@immutable
abstract class SpecialityState {}

class SpecialityInitial extends SpecialityState {}

class SpecialityLoading extends SpecialityState {}

class SpecialitySucess extends SpecialityState {
  final List<Speciality> specialityList;

  SpecialitySucess(this.specialityList);
}

class SpecialityFailure extends SpecialityState {
  final String errorMessage;

  SpecialityFailure(this.errorMessage);
}
