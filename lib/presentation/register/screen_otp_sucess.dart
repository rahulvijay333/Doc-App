import 'package:appoint_medic/application/create_user/otp_verify/bloc/otp_verify_bloc.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenOtpSuccess extends StatelessWidget {
  const ScreenOtpSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          BlocProvider.of<OtpVerifyBloc>(context).add(ClearOtpVerifyState());

          return true;
        },
        child: Scaffold(
          body: Container(
            color: Colors.white,
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/otp_success.gif'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Email Verified',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
                SizedBox(
                  height: 30,
                  width: 80,
                  child: ElevatedButton(
                      onPressed: () {
                        //---------------------------------------------back to home
                        BlocProvider.of<OtpVerifyBloc>(context)
                            .add(ClearOtpVerifyState());
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const ScreenLogin(),
                            ),
                            (route) => false);
                      },
                      child: const Text('Login')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
