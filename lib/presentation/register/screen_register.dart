import 'dart:developer';

import 'package:appoint_medic/application/create_user/create_user_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:appoint_medic/presentation/register/screen_otp_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final ValueNotifier isDoctorNotifier = ValueNotifier(false);
  //-------------text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //error checkers
  String nameError = '', emailError = '', passwordError = '';
  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context1) {
    log('register page');
    final size = MediaQuery.of(context1).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          // decoration: backgroundDecoration,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  //  color: Colors.amber,
                  width: size.width,
                  height: size.height * 0.07,
                  child: Center(
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                          color: appBackGround,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        const Text(
                          'Full Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //------------------------------------------------------------name
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                nameError = 'Name required';
                              });
                            } else {
                              setState(() {
                                nameError = '';
                              });
                            }
                          },
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Full Name',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent))),
                        ),
                        SizedBox(
                          height: 18,
                          child: Text(
                            nameError,
                            style: TextStyle(
                                fontSize: 12,
                                color: nameError.isEmpty
                                    ? Colors.white
                                    : Colors.red),
                          ),
                        ),
                        //---------------------------------------------------------------email
                        const Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //-----------------------------------------------email field
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                emailError = 'Email required';
                              });
                            } else {
                              setState(() {
                                emailError = '';
                              });
                            }
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Email',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent))),
                        ),
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
                        //---------------------------------password
                        const Text(
                          'Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //-----------------------------------------------------------password
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                passwordError = 'Password required';
                              });
                            } else if (value.length < 16) {
                              setState(() {
                                passwordError = 'Password length should be 16';
                              });
                            } else {
                              setState(() {
                                passwordError = '';
                              });
                            }
                          },
                          maxLength: 16,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent))),
                        ),
                        SizedBox(
                          height: 15,
                          child: Text(
                            passwordError,
                            style: TextStyle(
                                fontSize: 12,
                                color: passwordError.isEmpty
                                    ? Colors.white
                                    : Colors.red),
                          ),
                        ),
                        Row(
                          children: [
                            const Text('Are you a doctor? '),
                            ValueListenableBuilder(
                              valueListenable: isDoctorNotifier,
                              builder: (context, value, child) {
                                return Checkbox(
                                  value: isDoctorNotifier.value,
                                  checkColor: Colors.white,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    isDoctorNotifier.value = value;
                                  },
                                );
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        Center(
                          child: SizedBox(
                            width: size.width * 0.4,
                            height: 40,
                            child: ElevatedButton(

                                //-----------------------------------------------------------------click create button
                                onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (nameError.isEmpty &&
                                    emailError.isEmpty &&
                                    passwordError.isEmpty) {
                                  final name = _nameController.text.trim();
                                  final email = _emailController.text.trim();
                                  final password =
                                      _passwordController.text.trim();
                                  final user = CreateUserModel(
                                      name: name,
                                      email: email,
                                      password: password);
                                  String userType = '';

                                  if (isDoctorNotifier.value == true) {
                                    userType = 'doctor';
                                  } else {
                                    userType = 'patient';
                                  }

                                  BlocProvider.of<CreateUserBloc>(context1).add(
                                      CreateButtonClicked(
                                          newUser: user, userType: userType));
                                }
                              }
                            }, child: BlocBuilder<CreateUserBloc,
                                    CreateUserState>(
                              builder: (context, state) {
                                if (state is CreateUserLoading) {
                                  return const Center(
                                    child: SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 1,
                                        )),
                                  );
                                }
                                //----------------------------------------------------account creation success
                                else if (state is CreateUserSuccess) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          // Build the new route/screen here
                                          return ScreenOtpVerify(
                                            emailID: state.email,
                                            userType: state.userType,
                                          );
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          // Define your custom transition animation here
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                    BlocProvider.of<CreateUserBloc>(context)
                                        .add(InitialiCreateBloc());
                                  });
                                }
                                //-------------------------------------------------------create accound failed
                                else if (state is CreateUserFailed) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration: Duration(seconds: 2),
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(15),
                                            content: Text(state.errorMessage)));
                                  });
                                  BlocProvider.of<CreateUserBloc>(context1)
                                      .add(InitialiCreateBloc());
                                }
                                return Text(
                                  'Create',
                                  style: TextStyle(
                                      fontSize: size.width * 0.4 * 0.08),
                                );
                              },
                            )),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                            onPressed: () {
                              //---------------------------------cancel form
                              BlocProvider.of<CreateUserBloc>(context1)
                                  .add(InitialiCreateBloc());
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.5)),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
