import 'package:appoint_medic/application/login/login_bloc.dart';
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
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
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
                      child: Center(
                          child: CircleAvatar(
                        backgroundImage: AssetImage('assets/patient.png'),
                        radius: 60,
                      )),
                    ),
                    Container(
                      width: size.width * 0.8 * 0.60,
                      // color: Colors.yellow,
                      height: size.height * 0.30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Name Here',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Phone',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Email id',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
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

              child: Column(
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
                  profile_button(
                    size: size,
                    optionName: 'Log Out',
                    icon: Icons.logout,
                  ),
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
                style: TextStyle(color: Colors.black),
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
