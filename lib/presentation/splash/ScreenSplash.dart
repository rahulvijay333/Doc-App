import 'package:appoint_medic/application/Auth/authentication_bloc.dart';
import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/admin/home/screen_admin_home.dart';
import 'package:appoint_medic/presentation/doctor/doc_main_screen.dart';
import 'package:appoint_medic/presentation/doctor/home/screen_doct_home.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:appoint_medic/presentation/patient/home/screen_home.dart';
import 'package:appoint_medic/presentation/patient/main_page.dart';
import 'package:appoint_medic/presentation/splash/logo/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      BlocProvider.of<AuthenticationBloc>(context).add(AppStartAuth());
      final authBloc = BlocProvider.of<AuthenticationBloc>(context);
      authBloc.stream.listen((state) {
        if (state is AuthenticationLoading) {
          // Handle loading state if necessary
        } else if (state is Autheticated) {
          if (state.role == 'doctor') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DoctorScreenMain(
                          token: state.token,
                          name: state.name,
                        )));
          } else if (state.role == 'patient') {
            //-----------------------------------------------------------------gettting profile details  event
            BlocProvider.of<ProfileDetailsBloc>(context)
                .add(GetProfileDetails(state.id));
            //------------------------------------------calling catagories event
            BlocProvider.of<SpecialityBloc>(context)
                .add(DisplaySpecialityHome());
            //----------------------------------------------
            BlocProvider.of<SearchBloc>(context).add(ShowAllDoctorList());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenMainPage(
                        userName: state.name,
                        id: state.id,
                      )),
            );
          } else if (state.role == 'admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenAdminHomePage(
                        name: state.name,
                      )),
            );
          }
        } else if (state is Unauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ScreenLogin()),
          );
        }
      });
    });

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 145, 255, 10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: FadeInContainer()),
            ],
          ),
        ),
      ),
    );
  }
}

// class ScreenSplash extends StatelessWidget {
//   const ScreenSplash({super.key});

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<AuthenticationBloc>(context).add(AppStartAuth());

//     return BlocListener<AuthenticationBloc, AuthenticationState>(
//         listener: (context, state) {
//           if (state is AuthenticationLoading) {
//             Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is Autheticated) {
//             //------------------------------------------------------------------doctor
//             if (state.role == 'doctor') {
//               WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ScreenDoctorHome(),
//                     ));
//               });
//             }
//             //------------------------------------------------------------------patient
//             else if (state.role == 'patient') {
//               WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ScreenMainPage(),
//                     ));
//               });
//             }

//             //       //------------------------------------------------------------------------admin
//             else if (state.role == 'admin') {
//               WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (ctx) => ScreenAdminHomePage(),
//                     ));
//               });
//             }
//           }
//           //     //---------------------------------------------------------------------login page
//           else if (state is Unauthenticated) {
//             WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ScreenLogin(),
//                   ));
//             });
//           }
//         },
//         child: SafeArea(
//           child: Scaffold(
//             body: Column(
//               children: [
//                 Center(
//                   child: Text('Splash Screen'),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class ScreenSplash extends StatelessWidget {
//   const ScreenSplash({super.key});

//   Widget build(BuildContext context) {
//     BlocProvider.of<AuthenticationBloc>(context).add(AppStartAuth());
//     return SafeArea(
//       child:
//       //     Scaffold(body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//       //   builder: (context, state) {
//       //     if (state is AuthenticationLoading) {
//       //       return const Center(
//       //         child: Text('Check Authentication'),
//       //       );
//       //     } else if (state is Autheticated) {
//       //       //------------------------------------------------------------------doctor
//       //       if (state.role == 'doctor') {
//       //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       //           Navigator.pushReplacement(
//       //               context,
//       //               MaterialPageRoute(
//       //                 builder: (context) => ScreenDoctorHome(),
//       //               ));
//       //         });
//       //       } //------------------------------------------------------------------patient
//       //       else if (state.role == 'patient') {
//       //         WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
//       //           Navigator.pushReplacement(
//       //               context,
//       //               MaterialPageRoute(
//       //                 builder: (context) => ScreenMainPage(),
//       //               ));
//       //         });
//       //       }

//       //       //------------------------------------------------------------------------admin
//       //       else if (state.role == 'admin') {
//       //         WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
//       //           Navigator.pushReplacement(
//       //               context,
//       //               MaterialPageRoute(
//       //                 builder: (ctx) => ScreenMainPage(),
//       //               ));
//       //         });
//       //       }
//       //     }
//       //     //---------------------------------------------------------------------login page
//       //     else if (state is Unauthenticated) {
//       //       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       //         Navigator.pushReplacement(
//       //             context,
//       //             MaterialPageRoute(
//       //               builder: (context) => ScreenLogin(),
//       //             ));
//       //       });
//       //     } else if (state is AuthenticationError) {
//       //       return Center(child: Text('Error'));
//       //     }
//       //     return Center(
//       //       child: Text('splash screen loading'),
//       //     );
//       //   },
//       // )

//       ),
//     );
//   }
// }

// class ScreenSplash extends StatefulWidget {
//   const ScreenSplash({super.key});

//   @override
//   State<ScreenSplash> createState() => _ScreenSplashState();
// }

// class _ScreenSplashState extends State<ScreenSplash> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//         builder: (context, state) {
//           if (state is AuthenticationLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is Autheticated) {
//             if (state.role == 'patient') {
//               WidgetsFlutterBinding().addPostFrameCallback((timeStamp) {
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) {
//                     return const ScreenHome();
//                   },
//                 ));
//               });
//             } else if (state.role == 'doctor') {
//               WidgetsFlutterBinding().addPostFrameCallback((timeStamp) {
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) {
//                     return const ScreenDoctorHome();
//                   },
//                 ));
//               });
//             } else if (state.role == 'admin') {
//               WidgetsFlutterBinding().addPostFrameCallback((timeStamp) {
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) {
//                     return const ScreenAdminHomePage();
//                   },
//                 ));
//               });
//             }
//           } else if (state is Unauthenticated) {
//             WidgetsFlutterBinding().addPostFrameCallback((timeStamp) {
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (context) {
//                   return ScreenLogin();
//                 },
//               ));
//             });
//           }
//           return Text('Error occured while authentication');
//         },
//       ),
//     );
//   }
// }
