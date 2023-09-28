import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/application/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:appoint_medic/application/login/login_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/application/notifications/notificationStatus_track/bloc/notification_track_bloc.dart';
import 'package:appoint_medic/presentation/doctor/profile/widget/about_app.dart';
import 'package:appoint_medic/presentation/doctor/profile/widget/privacyD.dart';
import 'package:appoint_medic/presentation/doctor/profile/widget/screen_change_password.dart';
import 'package:appoint_medic/presentation/doctor/profile/widget/view.dart';
import 'package:appoint_medic/presentation/login/screen_login.dart';
import 'package:appoint_medic/presentation/patient/profile/widgets/termsAndConditions.dart';
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
            Expanded(
              child: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
                builder: (context, state) {
                  if (state is DoctorProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DoctorProfileSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                width: size.width * 0.8,
                                //  color: Colors.yellow,
                                height: size.height * 0.25,
                                //-------------------------------------------------------------profile bloc
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.8 * 0.45,
                                      // color: Colors.red,
                                      height: size.height * 0.18,
                                      child: Center(
                                          child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 80,
                                        child: ClipOval(
                                          child: Image.network(
                                            state.doctDetails.profilePicture!
                                                .secureUrl!,
                                            fit: BoxFit.cover,
                                            width: size.width * 0.8 * 0.50,
                                            height: size.height * 0.20,
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
                                                child:
                                                    CircularProgressIndicator(
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
                                      state.doctDetails.fullName!,maxLines: 1,
                                      style:  TextStyle(
                                          fontSize: size.width * 0.045,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                          Container(
                            // color: Colors.amber,
                            height: size.height * 0.55,
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
                                            return const ScreenViewPersonalDetails();
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
                                    child: ListTile(
                                      onTap: () {
                                        //----------------------------------------change password function

                                        context.read<ForgotPasswordBloc>().add(
                                            ForgotPasswordCall(
                                                message: 'message',
                                                userType: ''));

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return ScreenChangePasswordDoctor(
                                              userType: 'doctor',
                                              title: 'Change your passsord ?',
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
                                    color: Colors.white.withOpacity(0.6),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return const DoctorAboutWidget();
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
                                    color: Colors.white.withOpacity(0.6),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return const TermsAndConditionsWidget();
                                          },
                                        ));
                                      },
                                      leading: const Icon(
                                        Icons.book,
                                        color: Colors.blue,
                                      ),
                                      title: const Text('Terms and Conditions'),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Colors.white.withOpacity(0.6),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return DoctorPrivacyPolicyWidget();
                                          },
                                        ));
                                      },
                                      leading: const Icon(
                                        Icons.security,
                                        color: Colors.blue,
                                      ),
                                      title: const Text('Privacy'),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    if (state is LogoutLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
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
                                    } else if (state is LogOutFailed) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                              duration: Duration(seconds: 2),
                                              margin: EdgeInsets.all(15),
                                              behavior: SnackBarBehavior.floating,
                                                content: Text(
                                                    'Log out failed..')));
                                      });
                                    }

                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.white.withOpacity(0.6),
                                        child: ListTile(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title:
                                                      const Text('Important'),
                                                  content: const Text(
                                                      'Do you want to log out ?'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          //------------------------exit function
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('No')),
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
                                                              .add(LogOutButtonClicked(
                                                                  'doctor'));
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('yes'))
                                                  ],
                                                );
                                              },
                                            );
                                            //--------------------------------------------------------logout function
                                          },
                                          leading: const Icon(
                                            Icons.logout,
                                            color: Colors.blue,
                                          ),
                                          title: const Text('Log Out'),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
