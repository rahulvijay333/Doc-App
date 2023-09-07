import 'package:appoint_medic/application/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterNewPasswordWidget extends StatelessWidget {
  EnterNewPasswordWidget(
      {super.key,
      required this.size,
      required this.passkey,
      required this.typeUser,
      required this.token,
      required this.email, required this.newPasswordController, required this.confirmPasswordController});

  final Size size;
  final GlobalKey<FormState> passkey;
  final String token;
  final String email;
  final typeUser;
  final _formkeyPassword = GlobalKey<FormState>();

  final TextEditingController newPasswordController ;
  final TextEditingController confirmPasswordController ;
    

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Enter new password',
          style: TextStyle(
              fontSize: size.width * 0.06, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),

        //-----------------------------------email
        Form(
          key: passkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.002,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password required';
                  } else {
                    return null;
                  }
                },
                controller: newPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'confirm password  required';
                  } else {
                    return null;
                  }
                },
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: 'confirm password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Center(
                child: SizedBox(
                  height: 40,
                  width: size.width * 0.3,
                  child: ElevatedButton(
                      onPressed: () {
                        // BlocProvider.of<ForgotPasswordBloc>(context)
                        //     .add(EnterPasswordCall('email'));
                        //--------------------------------------------------------

                        if (passkey.currentState!.validate()) {
                          if (confirmPasswordController.text ==
                              newPasswordController.text) {
                            BlocProvider.of<ForgotPasswordBloc>(context).add(
                                NewPasswordResetCall(
                                    password: newPasswordController.text,
                                    confirmedPassword:
                                        confirmPasswordController.text,
                                    email: email,
                                    token: token,
                                    userType: typeUser));
                          } else {
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.only(
                                        left: 45, right: 45, bottom: 80),
                                    content: Center(
                                        child:
                                            Text('Passwords doesnt match'))));
                          }
                        }
                      },
                      child: Text('Next')),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
