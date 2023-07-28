import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: backgroundDecoration,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            const Text(
              'Profile',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: size.height * 0.25,
                width: size.width * 0.8,
                color: Colors.white.withOpacity(0.3),
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.8 * 0.40,
                      // color: Colors.red,
                      height: size.height * 0.30,
                      child: const Center(
                          child: CircleAvatar(
                        backgroundImage: AssetImage('assets/patient.png'),
                        radius: 60,
                      )),
                    ),
                    Container(
                      width: size.width * 0.8 * 0.60,
                      // color: Colors.yellow,
                      height: size.height * 0.30,
                      child:
                          BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ProfileSucess) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.userProfile.user!.fullName!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  state.userProfile.user!.phone!,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  state.userProfile.user!.email!,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            );
                          } else if (state is ProfileFailed) {
                            return Center(
                              child: Text('Error , Retry'),
                            );
                          }

                          return Center(
                            child: Text('Error , Retry'),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.10,
            ),
            Container(
              // color: Colors.amber,
              height: size.height * 0.40,
              width: size.width * 0.8,

              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  profile_button(
                    size: size,
                    optionName: 'Edit Profile',
                    icon: Icons.edit,
                  ),
                  profile_button(
                    size: size,
                    optionName: 'Change Password',
                    icon: Icons.password,
                  ),
                  profile_button(
                    size: size,
                    optionName: 'Payment details',
                    icon: Icons.payment_outlined,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state is LogoutLoading) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logging out...')));
                      });
                    } else if (state is LogoutSucess) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return ScreenLogin();
                          },
                        ));
                      });
                    }

                    return TextButton.icon(onPressed: () {

                      BlocProvider.of<LoginBloc>(context).add(LogOutButtonClicked('patient'));
                      
                    }, icon: Icon(Icons.logout), label: Text('Log out'));
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class profile_button extends StatelessWidget {
  const profile_button({
    super.key,
    required this.size,
    required this.optionName,
    required this.icon,
  });

  final String optionName;
  final IconData icon;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      height: size.height * 0.07,
      child: Row(
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                icon,
                color: Colors.grey,
              ),
              label: Text(
                optionName,
                style: const TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}

// Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Profile'),
//             BlocBuilder<LoginBloc, LoginState>(
//               builder: (context, state) {
//                 if (state is LogoutLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is LogoutSucess) {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       builder: (context) {
//                         return ScreenLogin();
//                       },
//                     ));
//                   });
//                 }

//                 return ElevatedButton(
//                     onPressed: () {
//                       BlocProvider.of<LoginBloc>(context)
//                           .add(LogOutButtonClicked('patient'));

//                       // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       //   builder: (context) {
//                       //     return ScreenLogin();
//                       //   },
//                       // ));
//                     },
//                     child: const Text('LogOut'));
//               },
//             )
//           ],
//         ),
//       )
