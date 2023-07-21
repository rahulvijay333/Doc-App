import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenDocProfile extends StatelessWidget {
  const ScreenDocProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Screeen'),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LogoutLoading) {
                  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Logging out...')));
                  // });

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LogoutSucess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) {
                        return ScreenLogin();
                      },
                    ));
                  });
                } else if (state is LogOutFailed) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logging out failed..')));
                  });
                }

                return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LogOutButtonClicked('doctor'));

                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //   builder: (ctx) {
                      //     return ScreenLogin();
                      //   },
                      // ));
                    },
                    child: const Text('LogOut'));
              },
            )
          ],
        ),
      ),
    );
  }
}
