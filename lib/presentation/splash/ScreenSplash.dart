import 'package:appoint_medic/application/Auth/authentication_bloc.dart';
import 'package:appoint_medic/application/HomeScreen_today_appointments/bloc/home_today_appointments_bloc.dart';
import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/bloc/view_all_chats_bloc.dart';
import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/application/notifications/notificationStatus_track/bloc/notification_track_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/doctor/doc_main_screen.dart';
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
    Future.delayed(const Duration(seconds: 4), () {
      BlocProvider.of<AuthenticationBloc>(context).add(AppStartAuth());
      final authBloc = BlocProvider.of<AuthenticationBloc>(context);
      authBloc.stream.listen((state) {
        if (state is AuthenticationLoading) {
          // Handle loading state if necessary
        } else if (state is Autheticated) {
          if (state.role == 'doctor') {
            
            context.read<NavbarBloc>().add(PageChangeEvent(page: 0));
            context.read<DoctorProfileBloc>().add(GetDoctorProfileCall());
            //------------------notifications refresh
             context
                .read<NotificationTrackBloc>()
                .add(CheckNotifications(userType: 'doctor'));

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DoctorScreenMain(
                    
                        
                        )));
          } else if (state.role == 'patient') {
        
            context.read<NavbarBloc>().add(PageChangeEvent(page: 0));
            //-----------------------------------------------------------------gettting profile details  event
            BlocProvider.of<ProfileDetailsBloc>(context)
                .add(GetProfileDetails(state.id));
            //------------------------------------------calling catagories event
            BlocProvider.of<SpecialityBloc>(context)
                .add(DisplaySpecialityHome());
            //----------------------------------------------
            //---------------------------calling today appointments list
            context
                .read<HomeTodayAppointmentsBloc>()
                .add(GetTodayAppointmentPatientCall());
            //-------------------------------------------
            context
                .read<NotificationTrackBloc>()
                .add(CheckNotifications(userType: 'patient'));

            BlocProvider.of<SearchBloc>(context).add(ShowAllDoctorList());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenMainPage(
                        userName: state.name,
                        id: state.id,
                      )),
            );
          }
        } else if (state is Unauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ScreenLogin()),
          );
        }
      });
    });

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 116, 217, 1),
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

