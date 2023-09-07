import 'dart:developer';

import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/application/navbar/navbar_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/domain/db/db_model.dart';
import 'package:appoint_medic/presentation/patient/appointments/screen_appointments.dart';
import 'package:appoint_medic/presentation/patient/home/screen_home.dart';
import 'package:appoint_medic/presentation/patient/messages/screen_message.dart';
import 'package:appoint_medic/presentation/patient/profile/screen_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({
    super.key,
    required this.userName,
    required this.id,
  });
  final String userName;
  final String id;
  final ValueNotifier<String> searchnotifier = ValueNotifier('');

  final searchMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pages = [
      ScreenHome(
        name: userName,
        id: id,
      ),
      const ScreenAppointments(),
      ScreenMesgsPatient(
        searchController: searchMessageController,
        searchnotifier: searchnotifier,
      ),
      ScreenProfile(
        id: id,
      )
    ];

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NavbarBloc, NavbarState>(
          builder: (context, state) {
            return pages[state.pageIndex];
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 25,right: 25,bottom: 20),
          child: Container(
            decoration: BoxDecoration(
                color: appBackGround, borderRadius: BorderRadius.circular(10)),
            height: 50,
            // width: size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<NavbarBloc>().add(PageChangeEvent(page: 0));
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<NavbarBloc>().add(PageChangeEvent(page: 1));
                    },
                    icon: const Icon(
                      Icons.edit_calendar_outlined,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<NavbarBloc>().add(PageChangeEvent(page: 2));
                    },
                    icon: const Icon(
                      Icons.message,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<NavbarBloc>().add(PageChangeEvent(page: 3));
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
