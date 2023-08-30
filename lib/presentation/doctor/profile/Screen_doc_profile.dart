import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/presentation/doctor/profile/widget/view.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenDocProfile extends StatelessWidget {
  const ScreenDocProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      // decoration: backgroundDecoration,
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Column(
          children: [
            Container(
              // color: Colors.blue,
              width: size.width,
              height: size.height * 0.07,
              child: const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
                builder: (context, state) {
                  if (state is DoctorProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DoctorProfileSuccess) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              width: size.width * 0.8,
                              //  color: Colors.yellow,
                              height: size.height * 0.30,
                              //-------------------------------------------------------------profile bloc
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: size.width * 0.8 * 0.50,
                                    // color: Colors.red,
                                    height: size.height * 0.20,
                                    child: Center(
                                        child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 80,
                                      child: ClipOval(
                                        child: Image.network(
                                          state.doctDetails.profilePicture!
                                              .secureUrl!,
                                          fit: BoxFit.cover,
                                          width: 160,
                                          height: 160,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/patient.png');
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }

                                            return const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.doctDetails.fullName!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                        Container(
                          // color: Colors.amber,
                          height: size.height * 0.40,
                          width: size.width * 0.90,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //------------------------------------------------------personal details
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.white.withOpacity(0.6),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return ScreenViewPersonalDetails();
                                        },
                                      ));
                                    },
                                    leading: const Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    ),
                                    title: const Text('Personal Details'),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              //--------------------------------------------------------change password
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.white.withOpacity(0.6),
                                  child: const ListTile(
                                    leading: Icon(
                                      Icons.password,
                                      color: Colors.blue,
                                    ),
                                    title: Text('Change Password'),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              //----------------------------------------------------------about
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.white.withOpacity(0.6),
                                  child: const ListTile(
                                    leading: Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                    ),
                                    title: Text('About Us'),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              //---------------------------------------------------
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.white.withOpacity(0.6),
                                  child: const ListTile(
                                    leading: Icon(
                                      Icons.book,
                                      color: Colors.blue,
                                    ),
                                    title: Text('Terms and Conditions'),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),

                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state is LogoutLoading) {
                                    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //       const SnackBar(content: Text('Logging out...')));
                                    // });

                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is LogoutSucess) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      // context
                                      //     .read<NavbarBloc>()
                                      //     .add(PageChangeEvent(page: 0));

                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) {
                                          return ScreenLogin();
                                        },
                                      ));
                                    });
                                  } else if (state is LogOutFailed) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Logging out failed..')));
                                    });
                                  }

                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.white.withOpacity(0.6),
                                      child: ListTile(
                                        onTap: () {
                                          //--------------------------------------------------------logout function
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(LogOutButtonClicked(
                                                  'doctor'));
                                        },
                                        leading: const Icon(
                                          Icons.logout,
                                          color: Colors.blue,
                                        ),
                                        title: const Text('Log Out'),
                                      ),
                                    ),
                                  );

                                  // return ElevatedButton(
                                  //     onPressed: () {
                                  //       BlocProvider.of<LoginBloc>(context)
                                  //           .add(LogOutButtonClicked('doctor'));

                                  //       // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  //       //   builder: (ctx) {
                                  //       //     return ScreenLogin();
                                  //       //   },
                                  //       // ));
                                  //     },
                                  //     child: const Text('LogOut'));
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (state is DoctorPrifleFailure) {
                    return Column(children: [
                      const Text('Error connecting to server'),
                      TextButton.icon(
                          onPressed: () {
                            //---------------------------------------refresh
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Refresh'))
                    ]);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ScreenDocProfile extends StatelessWidget {
//   const ScreenDocProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Profile Screeen'),
//             BlocBuilder<LoginBloc, LoginState>(
//               builder: (context, state) {
//                 if (state is LogoutLoading) {
//                   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                   //   ScaffoldMessenger.of(context).showSnackBar(
//                   //       const SnackBar(content: Text('Logging out...')));
//                   // });

//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is LogoutSucess) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     context.read<NavbarBloc>().add(PageChangeEvent(page: 0));

//                     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       builder: (context) {
//                         return ScreenLogin();
//                       },
//                     ));
//                   });
//                 } else if (state is LogOutFailed) {
//                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Logging out failed..')));
//                   });
//                 }

//                 return ElevatedButton(
//                     onPressed: () {
//                       BlocProvider.of<LoginBloc>(context)
//                           .add(LogOutButtonClicked('doctor'));

//                       // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       //   builder: (ctx) {
//                       //     return ScreenLogin();
//                       //   },
//                       // ));
//                     },
//                     child: const Text('LogOut'));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
