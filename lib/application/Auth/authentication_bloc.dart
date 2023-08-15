import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/domain/db/db_functions.dart';
import 'package:appoint_medic/infrastructure/auth/auth_service_impl.dart';
import 'package:bloc/bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SharedPrefsAuthServiceImpl sharedprefs;
  final DbFunctionClass db;
  final ProfileDetailsBloc profilebloc;

  AuthenticationBloc(
    this.sharedprefs,
    this.db,
    this.profilebloc,
  ) : super(Unauthenticated()) {
    on<AppStartAuth>((event, emit) async {
      emit(AuthenticationLoading());

      bool getLoginStatus = await sharedprefs.getLoggedInState();

      if (getLoginStatus == false) {
        emit(Unauthenticated());
      } else if (getLoginStatus == true) {
        String? getRole = await sharedprefs.getRole();
        String? getToken = await sharedprefs.getToken();
        String? userName = await sharedprefs.getName();
        String? userid = await sharedprefs.getId();

        // log(getToken.toString());

        emit(Autheticated(getRole!, getToken!, userName!, userid!));
        profilebloc.add(GetProfileDetails(userid));
      }
    });

    on<UserLoggedOut>((event, emit) {
      emit(Unauthenticated());
    });
  }
}
