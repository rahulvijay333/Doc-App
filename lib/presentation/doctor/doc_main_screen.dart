import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/presentation/doctor/all_appointments/all_appointments.dart';
import 'package:appoint_medic/presentation/doctor/avaliable_times/screen_avalibale_time.dart';
import 'package:appoint_medic/presentation/doctor/home/screen_doct_Home.dart';
import 'package:appoint_medic/presentation/doctor/messages/doct_message_screen.dart';
import 'package:appoint_medic/presentation/doctor/profile/Screen_doc_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/color_constants.dart';

class DoctorScreenMain extends StatelessWidget {
  DoctorScreenMain({
    super.key,
   
   
  });

 
  

  final TextEditingController searchController = TextEditingController();

  final ValueNotifier<String> searchnotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      const ScreenDoctHome(),
      const ScreenAllAppointments(),
      ScreenAvailableTime(
        
      ),
      ScreemDoctMessage(
          searchController: searchController, searchnotifier: searchnotifier),
      const ScreenDocProfile()
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
        body: BlocBuilder<NavbarBloc, NavbarState>(
          builder: (context, state) {
            return pages[state.pageIndex];
          },
        ),
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.06, bottom: size.width*0.05),
          child: Container(
            decoration: BoxDecoration(
               color: appBackGround, borderRadius: BorderRadius.circular(10)),
            height: size.height * 0.055,
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<NavbarBloc>(context)
                          .add(PageChangeEvent(page: 0));
                    },
                    icon:  Icon(size: size.width *0.06,
                      Icons.home,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<NavbarBloc>(context)
                          .add(PageChangeEvent(page: 1));
                    },
                    icon:  Icon(size: size.width *0.06,
                      Icons.edit_calendar_outlined,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<NavbarBloc>(context)
                          .add(PageChangeEvent(page: 2));
                    },
                    icon:  Icon(size: size.width *0.06,
                      Icons.access_time,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<NavbarBloc>(context)
                          .add(PageChangeEvent(page: 3));
                    },
                    icon:  Icon(size: size.width *0.06,
                      Icons.message,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<NavbarBloc>(context)
                          .add(PageChangeEvent(page: 4));
                    },
                    icon:  Icon(size: size.width *0.06,
                      Icons.person_2_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
