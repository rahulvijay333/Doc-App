import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/presentation/doctor/all_appointments/all_appointments.dart';
import 'package:appoint_medic/presentation/doctor/avaliable_times/screen_avalibale_time.dart';
import 'package:appoint_medic/presentation/doctor/home/screen_doct_Home.dart';
import 'package:appoint_medic/presentation/doctor/messages/doct_message_screen.dart';
import 'package:appoint_medic/presentation/doctor/profile/Screen_doc_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorScreenMain extends StatelessWidget {
   DoctorScreenMain({
    super.key,
    required this.name,
    required this.token,
  });

  final String name;
  final String token;

   final TextEditingController searchController = TextEditingController();

  final ValueNotifier<String> searchnotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pages = [
      ScreenDoctHome(
        name: name,
      ),
      const ScreenAllAppointments(),
      ScreenAvailableTime(
        token: token,
      ),
      ScreemDoctMessage(searchController: searchController,searchnotifier: searchnotifier),
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
            padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10),
            child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<NavbarBloc>(context)
                                  .add(PageChangeEvent(page: 0));
                            },
                            icon: const Icon(
                              Icons.home,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<NavbarBloc>(context)
                                  .add(PageChangeEvent(page: 1));
                            },
                            icon: const Icon(
                              Icons.edit_calendar_outlined,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<NavbarBloc>(context)
                                  .add(PageChangeEvent(page: 2));
                            },
                            icon: const Icon(
                              Icons.access_time,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<NavbarBloc>(context)
                                  .add(PageChangeEvent(page: 3));
                            },
                            icon: const Icon(
                              Icons.message,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<NavbarBloc>(context)
                                  .add(PageChangeEvent(page: 4));
                            },
                            icon: const Icon(
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
