import 'dart:developer';

import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/presentation/patient/search/widgets/all_doctors_widget.dart';
import 'package:appoint_medic/presentation/patient/search/widgets/searchByName.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});

  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<bool> checkSearchField = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    //log('Screen building ');
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: size.width,
          // decoration: backgroundDecoration,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 0,
              right: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.07,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            unfocus();
                            //-------------------------------------------pop function

                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                      const Expanded(
                          child: Text(
                        'All Doctors',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, bottom: 15, top: 20, right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            BlocProvider.of<SearchBloc>(context)
                                .add(SearchByName(value));
                            checkSearchField.value = true;
                          } else {
                            BlocProvider.of<SearchBloc>(context)
                                .add(ShowAllDoctorList());
                            checkSearchField.value = false;
                          }
                        },
                        controller: searchController,
                        cursorColor: Colors.grey,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            hintText: 'Search by name',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: checkSearchField,
                    builder: (context, valuepresent, child) {
                      if (valuepresent == false) {
                        return const AllDoctorWidget();
                      } else {
                        return const SearchByNameWidget();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to close the keyboard
  void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
