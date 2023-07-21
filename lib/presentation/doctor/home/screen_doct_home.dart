import 'package:appoint_medic/application/Auth/authentication_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenDoctorHome extends StatelessWidget {
  const ScreenDoctorHome({super.key, required this.user});

  final UserDb user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Doctor Home Page '),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LogoutLoading) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Logging out...')));
                        });
                      } else if (state is LogoutSucess) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) {
                              return ScreenLogin();
                            },
                          ));
                        });
                      }
    
                      return ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LogOutButtonClicked('doctor'));
    
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (ctx) {
                                return ScreenLogin();
                              },
                            ));
                          },
                          child: Text('LogOut'));
                    },
                  ),
                  Text('Doctor home page'),
                ],
              ),
              Text(user.name),
              Text(user.email)
            ],
          ),
        ),
      ),
    );
  }
}
