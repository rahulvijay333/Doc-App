import 'dart:developer';

import 'package:appoint_medic/application/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterEmailWidget extends StatelessWidget {
  const EnterEmailWidget(
      {super.key,
      required this.size,
      required this.emailKey,
      required this.typeUser,
      required this.emailAddressController,
      required this.title});
  final GlobalKey<FormState> emailKey;
  final Size size;
  final String typeUser;
  final TextEditingController emailAddressController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: size.width * 0.07, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),

        Text(
          'Please confirm your email',
          style: TextStyle(
              fontSize: size.width * 0.04,
              color: Colors.black.withOpacity(0.8)),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        //-----------------------------------email
        Form(
          key: emailKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email id*',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size.height * 0.008,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email required';
                  } else {
                    return null;
                  }
                },
                controller: emailAddressController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
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
                          if (emailKey.currentState!.validate()) {
                            log('go to password');
                            FocusScope.of(context).unfocus();

                            BlocProvider.of<ForgotPasswordBloc>(context).add(
                                EnterPasswordCall(
                                    email: emailAddressController.text,
                                    userType: typeUser));
                          }

                          //--------------------------------------------------------
                        },
                        child: Text('Proceed'))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
