import 'dart:developer';

import 'package:appoint_medic/domain/response_models/profile_model/profile_model.dart';
import 'package:appoint_medic/infrastructure/profile/profile_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_details_event.dart';
part 'profile_details_state.dart';

class ProfileDetailsBloc
    extends Bloc<ProfileDetailsEvent, ProfileDetailsState> {
  final ProfileService profileService;
  ProfileDetailsBloc(this.profileService) : super(ProfileDetailsInitial()) {
    on<GetProfileDetails>((event, emit) async {
      emit(ProfileLoading());

      try {
        final (error, respnse) =
            await profileService.getProfileDetails(id: event.id);

        if (error.isEmpty) {
          emit(ProfileSucess(respnse!));
        } else {
          emit(ProfileFailed(error));
        }
      } catch (e) {
        emit(ProfileFailed('Error happened in Profile Bloc'));
      }
    });
  }
}
