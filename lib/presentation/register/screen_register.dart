import 'dart:developer';

import 'package:appoint_medic/application/create_user/create_user_bloc.dart';
import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:appoint_medic/presentation/register/screen_otp_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenRegister extends StatefulWidget {
  // ScreenRegister({super.key});
  ScreenRegister({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final CreateServiceImpl createApiObject = CreateServiceImpl();

    return BlocProvider(
      create: (context) => CreateUserBloc(createApiObject),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.maxFinite,
            // decoration: backgroundDecoration,
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
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
                              color: Colors.blue,
                              fontSize: size.width * 0.07,
                              fontWeight: FontWeight.w500),
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
                          physics: BouncingScrollPhysics(),
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
                                } else {
                                  setState(() {
                                    passwordError = '';
                                  });
                                }
                              },
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
                                    final navigatorContext = Navigator.of(
                                            context,
                                            rootNavigator: true)
                                        .context;
                                    Navigator.of(navigatorContext)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (ctx) => ScreenOtpVerify(
                                        emailID: state.email,
                                        userType: state.userType,
                                      ),
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
                                 
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(state.errorMessage)));
                                  });
                                  BlocProvider.of<CreateUserBloc>(context)
                                      .add(InitialiCreateBloc());
                                }

                                return ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                        const Size(double.maxFinite, 50),
                                      ),
                                    ),
                                    //-----------------------------------------------------------------click create button
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (nameError.isEmpty &&
                                            emailError.isEmpty &&
                                            passwordError.isEmpty) {
                                          final name =
                                              _nameController.text.trim();
                                          final email =
                                              _emailController.text.trim();
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

                                          BlocProvider.of<CreateUserBloc>(
                                                  context)
                                              .add(CreateButtonClicked(
                                                  newUser: user,
                                                  userType: userType));
                                        }
                                      }
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
        ),
      ),
    );
  }
}
