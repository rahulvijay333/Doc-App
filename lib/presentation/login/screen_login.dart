import 'package:appoint_medic/application/HomeScreen_today_appointments/bloc/home_today_appointments_bloc.dart';
import 'package:appoint_medic/application/Onboarding/on_boarding_bloc.dart';
import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/application/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/doctor/AdminNotVerified/screen_admin_not_verified.dart';
import 'package:appoint_medic/presentation/doctor/doc_main_screen.dart';
import 'package:appoint_medic/presentation/login/screen_forgot_pass.dart';
import 'package:appoint_medic/presentation/onBoarding/doctor/screen_onb_doctor.dart';
import 'package:appoint_medic/presentation/patient/main_page.dart';
import 'package:appoint_medic/presentation/register/screen_register.dart';
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
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: appBackGround,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // physics: const BouncingScrollPhysics(),
                      children: [
                        Container(
                            // custom app bar
                            height: size.height * 0.07,
                            color: appBackGround,
                            width: size.width,
                            child: Center(
                              child: Text(
                                'AppointMedic',
                                style: TextStyle(
                                    fontSize: size.width * 0.055,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )),
        
                        //---------------------------------------image + text
                        Container(
                          color: appBackGround,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.04,
                              ),
        
                              //---------------------------------------app text
                              Text(
                                'Your Health, Our Priority',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.040,
                                    fontWeight: FontWeight.bold),
                              ),
                               Text(
                                'Book with Confidence!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.038,
                                    fontWeight: FontWeight.bold),
                              ),
        
        
        
                              SizedBox(
                                height: size.width * 0.045,
                              ),
                              //-----------------------------------------------image
                              Center(
                                child: Image.asset(
                                  'assets/logo_login.png',
                                  height: size.height * 0.32 * 0.60,
                                  width: size.width * 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //----------------------------------------------------------------------
        
                        //--------------------------------------email field
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                      child: Form(
                        key: _formkey,
                        child: Container(
                       
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  autofocus: false,
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
                                  controller: emailController,
                                  decoration: textfieldInputDecorationEmail),
                              SizedBox(
                                height: 18,
                                child: Text(
                                  emailError,
                                  style: TextStyle(
                                      fontSize: size.width * 0.028,
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
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration:
                                      textfieldInputDecorationPassword),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 18,
                                    child: Text(
                                      passwordError,
                                      style: TextStyle(
                                          fontSize: size.width * 0.028,
                                          color: passwordError.isEmpty
                                              ? Colors.white
                                              : Colors.red),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // FocusScope.of(context).unfocus();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop();
                                                    //--------------
                                                    context
                                                        .read<
                                                            ForgotPasswordBloc>()
                                                        .add(
                                                            ForgotPasswordCall(
                                                                message:
                                                                    'message',
                                                                userType:
                                                                    ''));
                                                    //-------------
        
                                                    Navigator.of(context)
                                                        .push(
                                                            MaterialPageRoute(
                                                      builder: (context) {
                                                        return ScreenForgotPassword(
                                                          userType: 'doctor',
                                                          title:
                                                              'Forgot your password ?',
                                                        );
                                                      },
                                                    ));
                                                  },
                                                  child:
                                                      const Text('Doctor')),
                                              //----------------------------------
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop();
        
                                                    context
                                                        .read<
                                                            ForgotPasswordBloc>()
                                                        .add(
                                                            ForgotPasswordCall(
                                                                message:
                                                                    'message',
                                                                userType:
                                                                    ''));
        
                                                    Navigator.of(context)
                                                        .push(
                                                            MaterialPageRoute(
                                                      builder: (context) {
                                                        return ScreenForgotPassword(
                                                          userType: 'patient',
                                                          title:
                                                              'Forgot your password ?',
                                                        );
                                                      },
                                                    ));
                                                  },
                                                  child:
                                                      const Text('Patient'))
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child:  Text(
                                      'Did you forget password ?',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: size.width * 0.03),
                                    ),
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
                                        child: SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                            )));
                                  } else if (state is LoginOnBordingPatient) {
                                  }
                                  //------------------------------------------------Onboradind doctor
                                  else if (state is LoginOnBordingDoctor) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      unfocus();
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
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
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) {
                                          return const ScreenAdminNotVerified();
                                        },
                                      ));
                                    });
                                  } else if (state is LoginSucess) {
                                    if (state.role == 'patient') {
                                      context
                                          .read<NavbarBloc>()
                                          .add(PageChangeEvent(page: 0));
                                      //-----------------------------------------------------------------gettting profile details  event
                                      BlocProvider.of<ProfileDetailsBloc>(
                                              context)
                                          .add(GetProfileDetails(state.id!));
                                      //------------------------------------------calling catagories event
                                      BlocProvider.of<SpecialityBloc>(context)
                                          .add(DisplaySpecialityHome());
                                      //----------------------------------------------calling today appoints
                                      context
                                          .read<HomeTodayAppointmentsBloc>()
                                          .add(
                                              GetTodayAppointmentPatientCall());
                                      //------------------------------------------
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        unfocus();
                                        Navigator.of(context).pushReplacement(
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
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        context
                                            .read<DoctorProfileBloc>()
                                            .add(GetDoctorProfileCall());
                                        context
                                            .read<NavbarBloc>()
                                            .add(PageChangeEvent(page: 0));
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DoctorScreenMain();
                                          },
                                        ));
                                      });
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    }
                                  } else if (state is LoginFailed) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration:
                                                  const Duration(seconds: 1),
                                              content: Text(state.error)));
                                    });
        
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  }
        
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      height: 50,
                                      width: size.width,
                                      child: ElevatedButton(
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
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                fontSize: size.width * 0.04),
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account yet? '),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) {
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
