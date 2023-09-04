import 'dart:developer';

import 'package:appoint_medic/application/create_user/otp_verify/bloc/otp_verify_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/core/text_constants.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:appoint_medic/presentation/register/otp_screen.dart';
import 'package:appoint_medic/presentation/register/otp_screen.dart';
import 'package:appoint_medic/presentation/register/screen_otp_sucess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenOtpVerify extends StatelessWidget {
  const ScreenOtpVerify({
    super.key,
    required this.userType,
    required this.emailID,
  });
  final String userType;
  final String emailID;

  @override
  Widget build(BuildContext context) {
    String otp1 = '';
    String otp2 = '';
    String otp3 = '';
    String otp4 = '';
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: size.width,
              color: Colors.blue,
              height: size.height * 0.07,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        //--------------------------exit
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      )),
                  const Text(
                    'OTP Verification',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      //color: Colors.white.withOpacity(0.5),
                      height: size.height * 0.6,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          // color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),

                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              'assets/email.png',
                              width: 50,
                              height: 50,
                            ),
                            const Text(
                              'Verify your email',
                              style: TextStyle(fontSize: 20),
                            ),
                            const Text(
                                'We have sent a 4 digit otp to this email id'),

                            Form(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 64,
                                    width: 68,
                                    child: TextFormField(
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      onSaved: (pin1) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          otp1 = value;
                                          log(value.toString());
                                          FocusScope.of(context).nextFocus();
                                        } else {
                                          otp1 = '';
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      textAlign: TextAlign.center,
                                      decoration: customOtpBoxdecoration(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    width: 68,
                                    child: TextFormField(
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      onSaved: (pin2) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          otp2 = value;
                                          FocusScope.of(context).nextFocus();
                                        } else {
                                          otp2 = '';
                                          FocusScope.of(context)
                                              .previousFocus();
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      textAlign: TextAlign.center,
                                      decoration: customOtpBoxdecoration(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    width: 68,
                                    child: TextFormField(
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      onSaved: (pin3) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          otp3 = value;
                                          FocusScope.of(context).nextFocus();
                                        } else {
                                          otp3 = '';
                                          FocusScope.of(context)
                                              .previousFocus();
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      textAlign: TextAlign.center,
                                      decoration: customOtpBoxdecoration(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 64,
                                    width: 68,
                                    child: TextFormField(
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      onSaved: (pin4) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          otp4 = value;
                                          // FocusScope.of(context).nextFocus();
                                        } else {
                                          otp4 = '';
                                          FocusScope.of(context)
                                              .previousFocus();
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      textAlign: TextAlign.center,
                                      decoration: customOtpBoxdecoration(),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            // ElevatedButton(
                            //     onPressed: () {
                            //       Navigator.of(context).pushAndRemoveUntil(
                            //           MaterialPageRoute(
                            //             builder: (context) => const ScreenLogin(),
                            //           ),
                            //           (route) => false);
                            //     },
                            //     child: const Text('Back to login'))

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: TextButton(
                                      onPressed: () {
                                        // Navigator.of(context).pushAndRemoveUntil(
                                        //     MaterialPageRoute(
                                        //       builder: (context) => const ScreenLogin(),
                                        //     ),
                                        //     (route) => false);
                                      },
                                      child: const Text('Resend OTP')),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: ElevatedButton(onPressed: () {
                                    log('some thig is');

                                    if (otp1.isNotEmpty &&
                                        otp2.isNotEmpty &&
                                        otp3.isNotEmpty &&
                                        otp4.isNotEmpty) {
                                      final String enteredOtp =
                                          otp1 + otp2 + otp3 + otp4;
                                      log(enteredOtp);

                                      //-------------------------------------------------call otp verify bloc
                                      context.read<OtpVerifyBloc>().add(
                                          OtpVerifyCall(
                                              email: emailID,
                                              otp: enteredOtp,
                                              userType: userType));
                                    }
                                  }, child: BlocBuilder<OtpVerifyBloc,
                                      OtpVerifyState>(
                                    builder: (context, state) {
                                      if (state is OtpVerifyLoading) {
                                        return const Center(
                                          child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 1,
                                              )),
                                        );
                                      } else if (state is OtpVerifySuccess) {
                                        //---------------------------------------------------------success new page
                                        Future.delayed(Duration.zero)
                                            .then((value) {
                                          final navigatorContext = Navigator.of(
                                                  context,
                                                  rootNavigator: true)
                                              .context;
                                          Navigator.of(navigatorContext)
                                              .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          ScreenOtpSuccess()));
                                        });
                                      } else if (state is OtpVerifyFailure) {
                                        //------------------------------------------------------handle
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'OTP Verification failed')));
                                        });
                                      }

                                      return const Text('Confirm');
                                    },
                                  )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
