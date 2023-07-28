part of 'profile_details_bloc.dart';

@immutable
abstract class ProfileDetailsState {}

class ProfileDetailsInitial extends ProfileDetailsState {}

class ProfileLoading extends ProfileDetailsState {}

class ProfileSucess extends ProfileDetailsState {
  final ProfileModel userProfile;

  ProfileSucess(this.userProfile);
}

class ProfileFailed extends ProfileDetailsState {
  final String errorMessage;

  ProfileFailed(this.errorMessage);
}
