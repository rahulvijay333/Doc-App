import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:appoint_medic/presentation/patient/profile/widgets/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key, required this.id});

  final String id;

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
              child: BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProfileSucess) {
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
                                          state.userProfile.user!
                                              .profilePicture!.secureUrl!,
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
                                    state.userProfile.user!.fullName!,
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
                                  color: Colors.blue[50]?.withOpacity(0.5),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return ScreenPersonalDetails();
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
                                  color: Colors.blue[50]?.withOpacity(0.5),
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
                                  color: Colors.blue[50]?.withOpacity(0.5),
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
                                  color: Colors.blue[50]?.withOpacity(0.5),
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
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                                left: 45,
                                                right: 45,
                                                bottom: 80),
                                            content: Center(
                                                child:
                                                    Text('Logging out...'))));
                                  });
                                } else if (state is LogoutSucess) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) {
                                        return ScreenLogin();
                                      },
                                    ));
                                  });

                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                } else if (state is LogOutFailed) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                                left: 45,
                                                right: 45,
                                                bottom: 80),
                                            content: Center(
                                                child:
                                                    Text('Logout failed..'))));

                                    context
                                        .read<LoginBloc>()
                                        .add(ClearLoginStateEvent());
                                  });
                                }

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Colors.blue[50]?.withOpacity(0.5),
                                    child: ListTile(
                                      onTap: () {
                                        //--------------------------------------------------------logout function
                                        BlocProvider.of<LoginBloc>(context).add(
                                            LogOutButtonClicked('patient'));
                                      },
                                      leading: const Icon(
                                        Icons.logout,
                                        color: Colors.blue,
                                      ),
                                      title: const Text('Log Out'),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (state is ProfileFailed) {
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
