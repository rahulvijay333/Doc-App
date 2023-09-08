import 'package:appoint_medic/application/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/notifications/notificationStatus_track/bloc/notification_track_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:appoint_medic/presentation/patient/profile/widgets/about.dart';
import 'package:appoint_medic/presentation/patient/profile/widgets/privacy.dart';
import 'package:appoint_medic/presentation/patient/profile/widgets/screen_change_password.dart';
import 'package:appoint_medic/presentation/patient/profile/widgets/termsAndConditions.dart';
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
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Center(
                          child: ClipRRect(
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
                                      //  color: Colors.red,
                                      height: size.width * 0.8 * 0.50,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        // radius: 80,
                                        child: ClipOval(
                                            child: state
                                                        .userProfile
                                                        .user!
                                                        .profilePicture
                                                        ?.secureUrl !=
                                                    null
                                                ? Image.network(
                                                    state
                                                        .userProfile
                                                        .user!
                                                        .profilePicture!
                                                        .secureUrl!,
                                                    fit: BoxFit.cover,
                                                    width: 160,
                                                    height: 160,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets/patient.png');
                                                    },
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }

                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Image.asset(
                                                    'assets/patient.png')),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        state.userProfile.user!.fullName ??
                                            state.userProfile.user!.name!,
                                        style: TextStyle(
                                            fontSize: size.width * 0.8 * 0.08,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        Center(
                          child: Container(
                            //  color: Colors.amber,
                            // height: size.height * 0.45,
                            width: size.width * 0.90,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //------------------------------------------------------personal details
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    // color: Colors.blue[50]?.withOpacity(0.5),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return const ScreenPersonalDetails();
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
                                    // color: Colors.blue[50]?.withOpacity(0.5),
                                    child: ListTile(
                                      onTap: () {
                                        //--------------------------------------chamge password function
                                        context.read<ForgotPasswordBloc>().add(
                                            ForgotPasswordCall(
                                                message: 'message',
                                                userType: ''));

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return ScreenChangePasswordPatient(
                                              userType: 'patient',
                                              title:
                                                  'Want to change password ?',
                                            );
                                          },
                                        ));
                                      },
                                      leading: const Icon(
                                        Icons.password,
                                        color: Colors.blue,
                                      ),
                                      title: const Text('Change Password'),
                                      trailing: const Icon(
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
                                    // color: Colors.blue[50]?.withOpacity(0.5),
                                    child: ListTile(
                                      onTap: () {
                                        //-------------------------------------------------------about

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return ScreenAbout();
                                          },
                                        ));
                                      },
                                      leading: const Icon(
                                        Icons.info,
                                        color: Colors.blue,
                                      ),
                                      title: const Text('About'),
                                      trailing: const Icon(
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
                                    // color: Colors.blue[50]?.withOpacity(0.5),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return TermsAndConditionsWidget();
                                          },
                                        ));
                                      },
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    // color: Colors.blue[50]?.withOpacity(0.5),
                                    child: ListTile(
                                      onTap: () {
                                        //----------------------privacy
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return PrivacyPolicyWidget();
                                          },
                                        ));
                                      },
                                      leading: Icon(
                                        Icons.security,
                                        color: Colors.blue,
                                      ),
                                      title: Text('Privacy'),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar( SnackBar(elevation: 0,
                                            backgroundColor: Colors.white,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(
                                                  left: 45,
                                                  right: 45,
                                                  bottom: size.height * 0.005),
                                              content: Center(
                                                  child:
                                                      Text('Logging out...',style: TextStyle(color: appBackGround)))));
                                    });
                                  } else if (state is LogoutSucess) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) {
                                          return const ScreenLogin();
                                        },
                                      ));
                                    });

                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  } else if (state is LogOutFailed) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar( SnackBar(
                                            
                                            elevation: 0,
                                            backgroundColor: Colors.white,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(
                                                  left: 45,
                                                  right: 45,
                                                  bottom: size.height * 0.005),
                                              content: Center(
                                                  child: Text(
                                                      'Logout failed..',style: TextStyle(color: Colors.red),))));

                                      context
                                          .read<LoginBloc>()
                                          .add(ClearLoginStateEvent());
                                    });
                                  }

                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      // color: Colors.blue[50]?.withOpacity(0.5),
                                      child: ListTile(
                                        onTap: () {
                                          //-------------------------------------logout function
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Important'),
                                                content: const Text(
                                                    'Do you want to log out ?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        //------------------------exit function
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('No')),
                                                  TextButton(
                                                      onPressed: () {
                                                        //------------------------logout  function
                                                        context
                                                            .read<
                                                                NotificationTrackBloc>()
                                                            .add(
                                                                ClearNotifications());
                                                        BlocProvider.of<
                                                                    LoginBloc>(
                                                                context)
                                                            .add(
                                                                LogOutButtonClicked(
                                                                    'patient'));
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('yes'))
                                                ],
                                              );
                                            },
                                          );
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
