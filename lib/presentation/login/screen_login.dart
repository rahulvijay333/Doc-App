import 'package:appoint_medic/application/HomeScreen_today_appointments/bloc/home_today_appointments_bloc.dart';
import 'package:appoint_medic/application/Onboarding/on_boarding_bloc.dart';
import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/doctor/AdminNotVerified/screen_admin_not_verified.dart';
import 'package:appoint_medic/presentation/doctor/doc_main_screen.dart';
import 'package:appoint_medic/presentation/onBoarding/doctor/screen_onb_doctor.dart';
import 'package:appoint_medic/presentation/onBoarding/patient/screen_onB_patient.dart';
import 'package:appoint_medic/presentation/patient/main_page.dart';
import 'package:appoint_medic/presentation/register/screen_register.dart';
import 'package:appoint_medic/presentation/splash/ScreenSplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

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
  @override
  void initState() {
    BlocProvider.of<OnBoardingBloc>(context).add(ClearOnboardingState());
    super.initState();
  }

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
        Text(label),
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
                        physics: const BouncingScrollPhysics(),
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
                                          //-------------loading
                                          if (state is LoginLoading) {
                                            unfocus();
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (state
                                              is LoginOnBordingPatient) {
                                            // WidgetsBinding.instance
                                            //     .addPostFrameCallback((_) {
                                            //   unfocus();
                                            //   Navigator.of(context)
                                            //       .pushReplacement(
                                            //           MaterialPageRoute(
                                            //     builder: (context) {
                                            //       return ScreenOnBoardingPatient(
                                            //         token: state.token,
                                            //       );
                                            //     },
                                            //   ));
                                            // });
                                          }
                                          //------------------------------------------------Onboradind doctor
                                          else if (state
                                              is LoginOnBordingDoctor) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              unfocus();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) {
                                                  return ScreenOnBoardingDoctor(
                                                    token: state.token,
                                                  );
                                                },
                                              ));
                                            });
                                          } else if (state
                                              is LoginAdminVerificationSate) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              unfocus();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) {
                                                  return ScreenAdminNotVerified();
                                                },
                                              ));
                                            });
                                          } else if (state is LoginSucess) {
                                            if (state.role == 'patient') {
                                              userType = 'Patient';
                                              context.read<NavbarBloc>().add(
                                                  PageChangeEvent(page: 0));
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
                                              //----------------------------------------------calling today appoints
                                              context
                                                  .read<
                                                      HomeTodayAppointmentsBloc>()
                                                  .add(
                                                      GetTodayAppointmentPatientCall());
                                              //------------------------------------------
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

                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            } else if (state.role == 'doctor') {
                                              userType = 'Doctor';
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                context
                                                    .read<DoctorProfileBloc>()
                                                    .add(
                                                        GetDoctorProfileCall());
                                                context.read<NavbarBloc>().add(
                                                    PageChangeEvent(page: 0));
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) {
                                                    return DoctorScreenMain(
                                                      name: state.name!,
                                                      token: state.token!,
                                                    );
                                                  },
                                                ));
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            }
                                          } else if (state is LoginFailed) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      duration:
                                                          Duration(seconds: 2),
                                                      content:
                                                          Text(state.error)));
                                            });

                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
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
