import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenAdminNotVerified extends StatelessWidget {
  const ScreenAdminNotVerified({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
                height: size.height * 0.07,
                color: appBackGround,
                width: size.width,
                child: Center(
                  child: Text(
                    'AppointMedic',
                    style: TextStyle(
                        fontSize: size.width * 0.055,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )),
            Expanded(
                child: Container(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.80,
                        child: Text(
                          'Your verification is under process and will complete  within 24hrs',
                          style: TextStyle(
                              fontSize: size.width * 0.035, color: Colors.red),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                          onPressed: () {
                            //-----------------------------------------back to login page

                            context
                                .read<LoginBloc>()
                                .add(ClearLoginStateEvent());

                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) {
                                return const ScreenLogin();
                              },
                            ));
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Back to login'))
                    ]),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
