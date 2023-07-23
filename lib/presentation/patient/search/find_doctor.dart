import 'dart:developer';

import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/patient/search/screen_search.dart';
import 'package:appoint_medic/presentation/patient/search/widgets/date_picker.dart';
import 'package:flutter/material.dart';

class ScreenFindDoctor extends StatefulWidget {
  ScreenFindDoctor({super.key});

  @override
  State<ScreenFindDoctor> createState() => _ScreenFindDoctorState();
}

class _ScreenFindDoctorState extends State<ScreenFindDoctor> {
  final ValueNotifier<String> selectedGender = ValueNotifier<String>('Male');

  final ValueNotifier<String> selectedSpeciality = ValueNotifier<String>('');

  String get selectedGenderTypeValue => selectedGender.value;

  String get selectedSpecialityTypeValue => selectedSpeciality.value;

  List<String> specialties = ['Cardiology', 'Dermatology'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print('${size.height * 0.010}');
    // print('${size.width * 0.4 * 0.6}');
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.blue,
          // appBar: AppBar(
          //   title: Text('Find doctor'),
          // ),
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.07,
                color: Colors.blue,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          //--------------------------------------pop function
                          Navigator.of(context).pop(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                // Build the new route/screen here
                                return const ScreenSearch();
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
                        },
                        //------------------------------back arrow
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const Text(
                      'Search',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height,
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.blue,
                        width: size.width * 0.4,
                        height: size.height * 0.2,
                        // color: Colors.red,
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/medical.png',
                            width: size.width * 0.4,
                            height: size.height * 0.4 * 0.50,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: size.height * 0.45,
                          width: size.width,
                          color: Colors.blue.shade100.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Date'),
                                const SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 50,
                                    color: Colors.white.withOpacity(1),
                                    child: DateSelector(
                                      selectedDate:
                                          '2023-07-22', // You can set the initial selected date here
                                      onDateSelected: (selectedDate) {
                                        // Handle the selected date here
                                        print('Selected Date: $selectedDate');
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('Gender'),
                                const SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 50,
                                    width: double.maxFinite,
                                    color: Colors.white.withOpacity(1),
                                    child: Wrap(
                                      children: [
                                        customRadioGender('Male'),
                                        customRadioGender('Female'),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('Speciality'),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Choose Speciality'),
                                          content: ConstrainedBox(
                                            // height: 200,
                                            constraints:
                                                BoxConstraints(maxHeight: 250),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: specialties
                                                    .map((speciality) {
                                                  return ListTile(
                                                    title: Text(speciality),
                                                    onTap: () {
                                                      selectedSpeciality.value =
                                                          speciality;
                                                      Navigator.of(context)
                                                          .pop();
                                                      //  log(selectedSpeciality
                                                      //    .value);'

                                                      print(selectedSpeciality
                                                          .value);
                                                    },
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  //--------------------------------------------close function
                                                },
                                                child: Text('close'))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                        height: 40,
                                        width: double.maxFinite,
                                        color: Colors.white.withOpacity(1),
                                        child: ValueListenableBuilder(
                                          valueListenable: selectedSpeciality,
                                          builder:
                                              (context, specilaity, child) {
                                            return Center(
                                              child: Text(
                                                specilaity.isNotEmpty
                                                    ? specilaity
                                                    : 'Choose Speciality', // Display selected speciality if available, otherwise display 'Choose Speciality'
                                                style: TextStyle(
                                                  color: specilaity.isNotEmpty
                                                      ? Colors.black
                                                      : Colors
                                                          .black, // Set text color based on selection
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Search')),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget customRadioGender(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          activeColor: Colors.blue,
          value: label,
          groupValue: selectedGender.value,
          onChanged: (String? value) {
            setState(() {
              selectedGender.value = value!;
            });
          },
        ),
        Text('$label'),
      ],
    );
  }

  Widget customRadioSpeciality(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          activeColor: Colors.blue,
          value: label,
          groupValue: selectedSpeciality.value,
          onChanged: (String? value) {
            setState(() {
              selectedSpeciality.value = value!;
            });
          },
        ),
        Text('$label'),
      ],
    );
  }
}
