import 'dart:developer';
import 'package:appoint_medic/application/Auth/authentication_bloc.dart';
import 'package:appoint_medic/domain/response_models/admin/admin_response/admin_response.dart';
import 'package:appoint_medic/domain/response_models/doctor_response/doctor_response.dart';
import 'package:appoint_medic/domain/response_models/patient/patient_response/patient_response.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';

import 'package:appoint_medic/infrastructure/auth/auth_service_impl.dart';
import 'package:appoint_medic/infrastructure/login/loginServiceImpl.dart';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginServiceImpl loginService;
  final AuthenticationBloc auth;
  final SharedPrefsAuthServiceImpl prefs;

  final SecureStorageService secureStorageService;

  LoginBloc(
    this.loginService,
    this.auth,
    this.prefs,
    this.secureStorageService,
  ) : super(LoginIntial()) {
    on<LoginButtonClicked>((event, emit) async {
      emit(LoginLoading());

      try {
        final (error, response) = await loginService.loginButton(
            password: event.password,
            email: event.username,
            logintype: event.logintype);

        if (error.isEmpty) {
          String? role = response?.user!.role;
          String? token = response?.user!.token;
          String? id = response?.user!.id;

          String? userName = '';

          if (response is DoctorResponse) {
            //-------------------------------------------------------directing to onborading doctor
            if (response.user!.fullName == null ||
                response.user!.fullName!.isEmpty) {
              emit(LoginOnBordingDoctor(token: response.user!.token!));
            } else if (response.user!.isAdminVerified == false) {
              emit(LoginAdminVerificationSate());
            } else {
              userName = response.user!.fullName;
              prefs.saveRole(role!);
              prefs.saveLoggedInState(true);
              prefs.saveToken(token!);
              prefs.saveName(userName!);
              prefs.saveId(id!);
              secureStorageService.storeToken(token);

              emit(LoginSucess(
                  role: role, name: userName, id: id, token: token));
            }
          } else if (response is PatientResponse) {
            prefs.saveRole(role!);
            prefs.saveLoggedInState(true);
            prefs.saveToken(token!);
            prefs.saveName(userName);
            prefs.saveId(id!);
            await secureStorageService.storeToken(token);

            emit(LoginSucess(role: role, name: userName, id: id, token: token));
          }
        } else {
          emit(LoginFailed(error));

          await Future.delayed(Duration(seconds: 1));

          emit(LoginIntial());
        }
      } catch (e) {
        log(e.toString());
        log(' login catch :::::Error happened in login bloc ');
      }
    });

    on<LogOutButtonClicked>((event, emit) async {
      emit(LogoutLoading());

      final (error, response) =
          await loginService.logoutButton(role: event.role);

      if (error.isEmpty) {
        await prefs.saveLoggedInState(false);
        await prefs.saveRole('');
        await prefs.saveToken('');
        await prefs.saveId('');

        await secureStorageService.deleteToken();

        emit(LogoutSucess());
        //----------------------------------updating authbloc
        auth.add(UserLoggedOut());
      } else if (error.isNotEmpty) {
        log('logout bloc failed');
        emit(LogOutFailed());
      }
    });

    on<ClearLoginStateEvent>((event, emit) {
      emit(LoginIntial());
    });
  }
}
