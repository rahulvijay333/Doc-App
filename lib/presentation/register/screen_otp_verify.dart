import 'dart:developer';
import 'package:appoint_medic/application/create_user/create_user_bloc.dart';
import 'package:appoint_medic/application/create_user/otp_verify/bloc/otp_verify_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/register/screen_otp_sucess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenOtpVerify extends StatelessWidget {
  ScreenOtpVerify({
    required this.userType,
    required this.emailID,
  });
  final String userType;
  final String emailID;
  final TextEditingController otpController1 = TextEditingController();
    final TextEditingController otpController2 = TextEditingController();
    final TextEditingController otpController3 = TextEditingController();
    final TextEditingController otpController4 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    log('otp loading');
    String otp1 = '';
    String otp2 = '';
    String otp3 = '';
    String otp4 = '';
    

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          warning_message(context);
          BlocProvider.of<CreateUserBloc>(context).add(InitialiCreateBloc());

          return false;
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: size.width,
                color: appBackGround,
                height: size.height * 0.07,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          //--------------------------exit

                          warning_message(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        )),
                     Text(
                      'OTP Verification',
                      style: TextStyle(fontSize: size.width * 0.04, color: Colors.white),
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
                               SizedBox(
                                height: size.height * 0.015,
                              ),
                              Image.asset(
                                'assets/email.png',
                                width: 50,
                                height: 50,
                              ),
                               Text(
                                'Verify your email',
                                style: TextStyle(fontSize: size.width*0.045),
                              ),
                               Text(
                                  'We have sent a 4 digit otp to your registered email',
                                  style: TextStyle(fontSize: size.width*0.03)
                                  ),
                              Form(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 68,
                                      child: TextFormField(
                                        controller: otpController1,
                                        autofocus: true,
                                        keyboardType: TextInputType.number,
                                        maxLength: 1,
                                        onSaved: (pin1) {},
                                        onChanged: (value) {
                                          if (value.length == 1) {
                                            otp1 = value;

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
                                        controller: otpController2,
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
                                        controller: otpController3,
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
                                        controller: otpController4,
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
                              SizedBox(
                                width: size.width * 0.4,
                                height: 40,
                                child: ElevatedButton(onPressed: () {
                                  if (otpController1.text.isNotEmpty &&
                                      otpController2.text.isNotEmpty &&
                                      otpController3.text.isNotEmpty &&
                                      otpController4.text.isNotEmpty) {
                                    final String enteredOtp =
                                        otpController1.text +
                                            otpController2.text +
                                            otpController3.text +
                                            otpController4.text;
                              
                                    log(enteredOtp);
                                    //-------------------------------------------------call otp verify bloc
                              
                                    BlocProvider.of<CreateUserBloc>(context).add(
                                        OtpVerificationCall(
                                            email: emailID,
                                            otp: enteredOtp,
                                            userType: userType));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            margin: EdgeInsets.all(15),
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                                'incomplete otp')));
                                  }
                                }, child:
                                    BlocBuilder<CreateUserBloc, CreateUserState>(
                                  builder: (context, state) {
                                    if (state is OtpVerificationLoading) {
                                      return const Center(
                                        child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 1,
                                            )),
                                      );
                                    } else if (state is OtpVerifiedSuccess) {
                                      //---------------------------------------------------------success new page
                              
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const ScreenOtpSuccess()));

                                                    
                                      });
                                    } else if (state is OtpVerifiedFailed) {
                                      //------------------------------------------------------handle
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar( SnackBar(
                                                duration: Duration(seconds: 2),
                                                margin: EdgeInsets.all(15),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                    state.error)));
                                      });
                                    }
                              
                                    return  Text('Verify',style: TextStyle(fontSize: size.width*0.04*0.8),);
                                  },
                                )),
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
      ),
    );
  }

  Future<dynamic> warning_message(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Important'),
          content: const Text('Do you want to exit from email verification ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //no
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  Navigator.of(context).pop();
                    BlocProvider.of<CreateUserBloc>(context).add(InitialiCreateBloc());
                 
                },
                child: const Text('Yes'))
          ],
        );
      },
    );
  }
}
