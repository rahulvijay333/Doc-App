import 'dart:developer';

import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/core/text_constants.dart';
import 'package:appoint_medic/presentation/admin/home/screen_admin_home.dart';
import 'package:appoint_medic/presentation/doctor/doc_main_screen.dart';
import 'package:appoint_medic/presentation/login/screen_login_admin.dart';
import 'package:appoint_medic/presentation/patient/main_page.dart';
import 'package:appoint_medic/presentation/register/screen_register.dart';
import 'package:flutter/gestures.dart';
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

  final _formkey = GlobalKey<FormState>();
  String emailError = '';
  String passwordError = '';

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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blue,
        body: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              // decoration: backgroundDecoration,
              child: Column(
                children: [
                  //------------------------------------------------item
                  Expanded(
                    child: Container(
                        height: size.height * 0.07,
                        color: Colors.blue,
                        width: size.width,
                        child: const Center(
                          child: Text(
                            'DocCure',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                  ),
                  //-----------------------------------------------------app name
                  //------------------------------------item 2
                  Expanded(
                    flex: 12,
                    child: Container(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          //---------------------------------------image + text
                          Container(
                            // height: size.height * 0.35,
                            color: Colors.blue,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 35,
                                ),
                                //---------------------------------------app text
                                const Text(
                                  'Your Health, Our Priority: Book with Confidence!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                          //----------------------------------------------------------------------

                          const SizedBox(
                            height: 20,
                          ), //--------------------------------------email field
                          Container(
                            color: Colors.white,
                            //height: size.height * 0.42,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 10),
                              child: Form(
                                key: _formkey,
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              setState(() {
                                                emailError = 'Email required';
                                              });
                                            } else {
                                              setState(() {
                                                emailError = '';
                                              });
                                            }
                                          },
                                          controller: emailController,
                                          decoration:
                                              textfieldInputDecorationEmail),
                                      SizedBox(
                                        height: 18,
                                        child: Text(
                                          emailError,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: emailError.isEmpty
                                                  ? Colors.white
                                                  : Colors.red),
                                        ),
                                      ),
                                      //----------------------------------------------password field
                                      const Text(
                                        'Password',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              setState(() {
                                                passwordError =
                                                    'Password required';
                                              });
                                            } else {
                                              setState(() {
                                                passwordError = '';
                                              });
                                            }
                                          },
                                          obscureText: true,
                                          controller: passwordController,
                                          decoration:
                                              textfieldInputDecorationPassword),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 18,
                                            child: Text(
                                              passwordError,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: passwordError.isEmpty
                                                      ? Colors.white
                                                      : Colors.red),
                                            ),
                                          ),
                                          const Text(
                                            'Did you forget password ?',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12),
                                          ),
                                        ],
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
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (state is LoginSucess) {
                                            if (state.role == 'patient') {
                                              //-----------------------------------------------------------------gettting profile details  event
                                              BlocProvider.of<
                                                          ProfileDetailsBloc>(
                                                      context)
                                                  .add(GetProfileDetails(
                                                      state.id!));
                                              //------------------------------------------calling catagories event
                                              BlocProvider.of<SpecialityBloc>(
                                                      context)
                                                  .add(DisplaySpecialityHome());
                                              //----------------------------------------------
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                unfocus();
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) {
                                                    return ScreenMainPage(
                                                      userName: state.name!,
                                                      id: state.id!,
                                                    );
                                                  },
                                                ));
                                              });
                                            } else if (state.role == 'doctor') {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) {
                                                    return DoctorScreenMain(
                                                      name: state.name!,
                                                    );
                                                  },
                                                ));
                                              });
                                            } else if (state.role == 'admin') {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
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
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text(state.error)));
                                            });
                                          }

                                          return ElevatedButton(
                                              style: loginButtonStyle,
                                              onPressed: () {
                                                if (_formkey.currentState!
                                                    .validate()) {
                                                  if (passwordError.isEmpty &&
                                                      emailError.isEmpty) {
                                                    BlocProvider.of<LoginBloc>(
                                                            context)
                                                        .add(LoginButtonClicked(
                                                            emailController.text
                                                                .trim(),
                                                            passwordController
                                                                .text
                                                                .trim(),
                                                            selectedUserTypeValue));
                                                  }
                                                }
                                              },
                                              child: const Text(
                                                'Login',
                                                style: TextStyle(fontSize: 18),
                                              ));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
        bottomNavigationBar: Container(
          color: Colors.white,
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
