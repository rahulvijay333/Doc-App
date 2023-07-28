part of 'profile_details_bloc.dart';

@immutable
abstract class ProfileDetailsEvent {}

class GetProfileDetails extends ProfileDetailsEvent {
  final String id;

  GetProfileDetails(this.id);
}
