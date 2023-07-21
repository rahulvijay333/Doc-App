import 'dart:developer';

import 'package:appoint_medic/application/Auth/authentication_bloc.dart';
import 'package:appoint_medic/domain/db/db_functions.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/domain/response_models/admin/admin_response/admin_response.dart';

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
  final DbFunctionClass dbFunction;

  LoginBloc(
    this.loginService,
    this.auth,
    this.prefs,
    this.dbFunction,
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

          String? userName = '';
          if (response is AdminResponse) {
            userName = response.user!.role;
          } else {
            userName = response?.user!.name;
          }

          prefs.saveRole(role!);
          prefs.saveLoggedInState(true);
          prefs.saveToken(token!);
          prefs.saveName(userName!);

          //---------------------------------------------------saving details to hive
          // final UserDb user = await dbFunction.saveToDatabaseFunction(response);

          emit(LoginSucess(role: role, name: userName));
        } else {
          emit(LoginFailed(error));

          if (emit.isDone) {
            emit(LoginIntial());
          }
        }
      } catch (e) {
        log(e.toString());
        log('Error happened in login bloc ');
      }
    });

    on<LogOutButtonClicked>((event, emit) async {
      emit(LogoutLoading());

      final (error, response) =
          await loginService.logoutButton(role: event.role);

      if (error.isEmpty) {
        log('logout bloc sucess');
        await prefs.saveLoggedInState(false);
        await prefs.saveRole('');
        await prefs.saveToken('');

        await dbFunction.clearDb();

        emit(LogoutSucess());
        //----------------------------------updating authbloc
        auth.add(UserLoggedOut());
      } else if (error.isNotEmpty) {
        log('logout bloc failed');
        emit(LogOutFailed());
      }
    });
  }
}
