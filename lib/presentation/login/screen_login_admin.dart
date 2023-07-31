import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/core/text_constants.dart';
import 'package:appoint_medic/presentation/admin/home/screen_admin_home.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenAdminLogin extends StatelessWidget {
  ScreenAdminLogin({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
                            'Admin',
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

                    const SizedBox(
                      height: 25,
                    ),
                    //-----------------------------------------------image

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

                 
                    const SizedBox(
                      height: 10,
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
                          if (state.role == 'admin') {
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

                        return ElevatedButton(
                            style: loginButtonStyle,
                            onPressed: () {
                              //---------------------------------login function
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginButtonClicked(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      'admin'));
                            },
                            child: const Text('Login'));
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) {
                              return ScreenLogin();
                            },
                          ));
                        },
                        child: Text(
                          'Close',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                        ))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
