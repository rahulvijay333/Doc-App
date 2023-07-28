import 'dart:developer';

import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/core/text_constants.dart';
import 'package:appoint_medic/presentation/admin/home/screen_admin_home.dart';
import 'package:appoint_medic/presentation/doctor/doc_main_screen.dart';
import 'package:appoint_medic/presentation/login/screen_login_admin.dart';
import 'package:appoint_medic/presentation/patient/main_page.dart';
import 'package:appoint_medic/presentation/register/screen_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<String> selectedUserType =
      ValueNotifier<String>('patient');

  String get selectedUserTypeValue => selectedUserType.value;


   Widget customRadio(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          activeColor: Colors.blue,
          value: label,
          groupValue: selectedUserType.value,
          onChanged: (String? value) {
            setState(() {
              selectedUserType.value = value!;
            });
          },
        ),
        Text('$label'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: backgroundDecoration,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListView(
                  physics: const ScrollPhysics(),
                  children: [
                    //-----------------------------------------------------app name
                    const Center(
                      child: SizedBox(
                          height: 30,
                          child: Text(
                            'DocCure',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    //---------------------------------------app text
                    const Text(
                      textlogin,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //-----------------------------------------------image
                    Center(
                      child: Image.asset(
                        'assets/logo_login.png',
                        height: 180,
                        width: 280,
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ), //--------------------------------------email field
                    TextFormField(
                        controller: emailController,
                        decoration: textfieldInputDecorationEmail),
                    const SizedBox(
                      height: 15,
                    ),
                    //----------------------------------------------password field
                    TextFormField(
                        controller: passwordController,
                        decoration: textfieldInputDecorationPassword),
                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      'Did you forget password ?',
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Wrap(
                        children: [
                          customRadio('patient'),
                          customRadio('doctor'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //-----------------------------------------------------login button

                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is LoginSucess) {
                          if (state.role == 'patient') {
                            WidgetsBinding.instance.addPostFrameCallback((_) {

                              unfocus();
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return ScreenMainPage(
                                    userName: state.name!,
                                    id: state.id!,
                                  );
                                },
                              ));
                            });
                          } else if (state.role == 'doctor') {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return DoctorScreenMain(
                                    name: state.name!,
                                  );
                                },
                              ));
                            });
                          } else if (state.role == 'admin') {
                            WidgetsBinding.instance.addPostFrameCallback((_) {

                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return ScreenAdminHomePage(
                                    name: state.name!,
                                  );
                                },
                              ));
                            });
                          }
                        } else if (state is LoginFailed) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)));
                          });
                        }
                       // final usertype = selectedUserType.value;

                        return ElevatedButton(
                            style: loginButtonStyle,
                            onPressed: () {
                              //---------------------------------login function
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginButtonClicked(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      selectedUserTypeValue));
                            },
                            child: const Text('Login'));
                      },
                    )
                  ],
                ),
              ),
            )),
        bottomNavigationBar: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account yet? '),
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                      builder: (context) {
                        return ScreenRegister();
                      },
                    ));
                  },
                  child: const Text('SignUp')),
              const Text('|'),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) {
                        return ScreenAdminLogin();
                      },
                    ));
                  },
                  child: const Text('Admin'))
            ],
          ),
        ),
      ),
    );
  }

  void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

 
}
