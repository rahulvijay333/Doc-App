import 'dart:developer';

import 'package:appoint_medic/application/create_user/create_user_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:appoint_medic/presentation/register/screen_sucess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenRegister extends StatelessWidget {
  // ScreenRegister({super.key});
  ScreenRegister({Key? key}) : super(key: key);

  final ValueNotifier isDoctorNotifier = ValueNotifier(false);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
 
    final CreateServiceImpl createApiObject = CreateServiceImpl();

    return BlocProvider(
      create: (context) => CreateUserBloc(createApiObject),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.maxFinite,
            decoration: backgroundDecoration,
            child: Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    // color: Colors.amber,
                    width: size.width,
                    height: size.height * 0.09,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.07,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //------------------------------------------------------------name
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: 'ex.Alex',
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
                        fillColor: Colors.white,
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'example@gmail.com',
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
                        fillColor: Colors.white,
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //-----------------------------------------------------------password
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'password',
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
                        fillColor: Colors.white,
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.transparent))),
                  ),
                  const SizedBox(
                    height: 10,
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
                              log(isDoctorNotifier.value.toString());
                            },
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BlocBuilder<CreateUserBloc, CreateUserState>(
                    builder: (context, state) {
                      //------------------------------------------------------intial loading
                      if (state is CreateUserLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      //----------------------------------------------------account creation success
                      else if (state is CreateUserSuccess) {
                        // WidgetsBinding.instance
                        //     .addPersistentFrameCallback((_) {
                        //   final navigatorContext =
                        //       Navigator.of(context, rootNavigator: true)
                        //           .context;
                        //   Navigator.of(navigatorContext)
                        //       .pushReplacement(MaterialPageRoute(
                        //     builder: (ctx) =>
                        //         const ScreenCreateAccountSuccess(),
                        //   ));
                        // });

                        Future.delayed(Duration.zero, () {
                          final navigatorContext =
                              Navigator.of(context, rootNavigator: true)
                                  .context;
                          Navigator.of(navigatorContext)
                              .pushReplacement(MaterialPageRoute(
                            builder: (ctx) =>
                                const ScreenCreateAccountSuccess(),
                          ));
                        });

                        // Future.delayed(Duration(seconds: 3)).then((value) {
                        //   final navigatorContext =
                        //       Navigator.of(context, rootNavigator: true)
                        //           .context;
                        //   Navigator.of(navigatorContext).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (ctx) =>
                        //               const ScreenCreateAccountSuccess()));
                        // });

                        print('sucess in state ');
                      }
                      //-------------------------------------------------------create accound failed
                      else if (state is CreateUserFailed) {
                        log('error is state : ${state.errorMessage}');
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)));
                        });
                        BlocProvider.of<CreateUserBloc>(context)
                            .add(InitialiCreateBloc());
                      }

                      return ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(double.maxFinite, 50),
                            ),
                          ),
                          //-----------------------------------------------------------------click create button
                          onPressed: () {
                            final name = _nameController.text.trim();
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            final user = CreateUserModel(
                                name: name, email: email, password: password);
                            String userType = '';

                            if (isDoctorNotifier.value == true) {
                              userType = 'doctor';
                            } else {
                              userType = 'patient';
                            }

                            BlocProvider.of<CreateUserBloc>(context).add(
                                CreateButtonClicked(
                                    newUser: user, userType: userType));
                          },
                          child: const Text(
                            'Create',
                            style: TextStyle(fontSize: 20),
                          ));
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        //---------------------------------cancel form
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.5)),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
