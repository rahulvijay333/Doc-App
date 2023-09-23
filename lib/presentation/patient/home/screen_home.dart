import 'package:appoint_medic/application/HomeScreen_today_appointments/bloc/home_today_appointments_bloc.dart';
import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/application/notifications/bloc/view_notifications_bloc.dart';
import 'package:appoint_medic/application/notifications/notificationStatus_track/bloc/notification_track_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/domain/response_models/get_specialities_response/speciality.dart';

import 'package:appoint_medic/presentation/patient/home/widgets/home_appointments_tile.dart';
import 'package:appoint_medic/presentation/patient/home/widgets/notification_bell.dart';
import 'package:appoint_medic/presentation/patient/notification/screen_notification.dart';
import 'package:appoint_medic/presentation/patient/search/screen_search.dart';
import 'package:appoint_medic/presentation/patient/search/screen_speclty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({
    super.key,
    required this.name,
    required this.id,
  });

  final String name;
  final String id;

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context
        .read<HomeTodayAppointmentsBloc>()
        .add(GetTodayAppointmentPatientCall());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      // height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //-------------------------------------------------1st section
            Container(
              // height: size.height * 0.23,
      
              color: appBackGround,
              child: Column(
                children: [
                  //---------------------------profile details
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
                      builder: (context, state) {
                        if (state is ProfileLoading) {
                          //-------------------------------loading
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            ),
                          );
                        }
                        //-------------------------------------------sucess
                        else if (state is ProfileSucess) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //welcome
                              Container(
                                  //  color: Colors.amber,
      
                                  child: CircleAvatar(
                                      radius: size.width * 0.07,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: state.userProfile.user!
                                                  .profilePicture?.secureUrl !=
                                              null
                                          ? NetworkImage(state.userProfile.user!
                                              .profilePicture!.secureUrl!)
                                          : const AssetImage('assets/patient.png')
                                              as ImageProvider)),
      
                              //---------------------------------------name and welcome
      
                              Padding(
                                padding: EdgeInsets.only(left: size.width * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Welcome ,',
                                      style: TextStyle(
                                          fontSize: size.width * 0.045,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      state.userProfile.user?.fullName ??
                                          state.userProfile.user!.name!,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: size.width * 0.064,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
      
                              //------------------------------------------reminder icon
                              InkWell(onTap: () {
                                context.read<ViewNotificationsBloc>().add(
                                    GetNotifications(
                                        notificationUserType: 'patient'));
      
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation, secondaryAnimation) {
                                      // Build the new route/screen here
                                      return ScreenNotification();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      // Define your custom transition animation here
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }, child: BlocBuilder<NotificationTrackBloc,
                                  NotificationTrackState>(
                                builder: (context, state) {
                                  return NotificationBell(
                                      notificationCount: state.notificationCount);
                                },
                              ))
                            ],
                          );
                        } else if (state is ProfileFailed) {
                          return Center(
                            child: IconButton(
                                onPressed: () {
                                  //-----------------------------------reload
                                  context
                                      .read<ProfileDetailsBloc>()
                                      .add(GetProfileDetails(widget.id));
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                )),
                          );
                        }
      
                        return const SizedBox();
                      },
                    ),
                  ),
      
                  //---------------------------------------------search doctors
                  GestureDetector(
                    onTap: () {
                      //----------------------------search page navigation
                      BlocProvider.of<SearchBloc>(context)
                          .add(ShowAllDoctorList());
      
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            // Build the new route/screen here
                            return ScreenSearch();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            // Define your custom transition animation here
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
                        right: size.width * 0.01,
                      ),
                      child: Container(
                        height: size.height * 0.09,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.search),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Search doctors ..')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
              ),
              child: Text(
                'Specialities',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: appBackGround),
              ),
            ),
            //---------------------------------------------------------------specility
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.05, right: size.width * 0.05, top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: size.height * 0.13,
                  width: size.width >700 ? null :size.width,
                  color: appBackGround.withOpacity(0.2),
                  child: BlocBuilder<SpecialityBloc, SpecialityState>(
                    builder: (context, state) {
                      if (state is SpecialityLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      } else if (state is SpecialitySucess) {
                        return Padding(
                          padding:  EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.02),
                          child: ListView.separated(
                            shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return ScreenSpeciality(
                                                speciality:
                                                    state.specialityList[index]);
                                          },
                                        ));
                                      },
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: Image.network(state
                                            .specialityList[index]
                                            .specialityImg!
                                            .secureUrl!),
                                      ),
                                    ),
                                    Text(state.specialityList[index].name!)
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 14,
                                );
                              },
                              itemCount: state.specialityList.length),
                        );
                      } else if (state is SpecialityFailure) {
                        return Center(
                          child: IconButton(
                              onPressed: () {
                                //----------------------------------------------------reload speciality
                                context
                                    .read<SpecialityBloc>()
                                    .add(DisplaySpecialityHome());
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.blue,
                              )),
                        );
                      }
      
                      return const Center(
                        child: Text('Connectivity error'),
                      );
                    },
                  ),
                ),
              ),
            ),
      
            //------------------------------------------2nd section
            Container(
              // color: Colors.red,
              width: size.width,
              // height: size.height * 0.45,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    top: size.height * 0.65 * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today Appointments',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: appBackGround),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      //  color: Colors.amber,
                      height: size.height * 0.38,
                      width: size.width,
                      child: BlocBuilder<HomeTodayAppointmentsBloc,
                          HomeTodayAppointmentsState>(
                        builder: (context, state) {
                          if (state is HomeTodayAppointsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            );
                          }
      
                          if (state is HomeTodayAppointsSuccess) {
                            if (state.appointmentList.isEmpty) {
                              return const Center(
                                child: Text('No Appointments Today'),
                              );
                            }
      
                            return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return HomeAppointmentsTile(
                                    size: size,
                                    date: state
                                        .appointmentList[index].selectedDate!,
                                    doctorname: state
                                        .appointmentList[index].doctor!.fullName!,
                                    startTime:
                                        state.appointmentList[index].startTime!,
                                    endTime:
                                        state.appointmentList[index].endTime!,
                                    speciality: state
                                        .appointmentList[index].speciality!.name!,
                                    doctImageUrl: state.appointmentList[index]
                                        .doctor!.profilePicture!.secureUrl!,
                                    bookingStatus: state
                                        .appointmentList[index].isApprovedByDoctor
                                        .toString(),
                                    doctorID:
                                        state.appointmentList[index].doctor!.id!,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: state.appointmentList.length);
                          } else if (state is HomeTodayAppointsFailure) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Reload'),
                                const SizedBox(
                                  height: 5,
                                ),
                                IconButton(
                                    onPressed: () {
                                      //------------------------------------------refresh function
                                      context
                                          .read<HomeTodayAppointmentsBloc>()
                                          .add(GetTodayAppointmentPatientCall());
                                    },
                                    icon: const Icon(Icons.refresh))
                              ],
                            );
                          } else {
                            return Center(
                              child: Text('Nothings to display'),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
