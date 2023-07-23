import 'dart:developer';

import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/patient/home/screen_home.dart';
import 'package:appoint_medic/presentation/patient/search/find_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<SearchBloc>(context).add(ShowAllDoctorList());
    log('Screen building ');
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.blue,
        body: Container(
          width: size.width,
          decoration: backgroundDecoration,
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
                  // color: Colors.blue,
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
                      Expanded(
                          child: TextFormField(
                        autofocus: true,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            hintText: 'Search by name',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      )),
                      TextButton(
                          onPressed: () {
                            //-------------------------------------push to next advnce page
                            unfocus();
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  // Build the new route/screen here
                                  return ScreenFindDoctor();
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
                          child: Row(
                            children: [
                              Icon(Icons.filter_alt,
                                  color: Colors.black.withOpacity(0.5)),
                              Text(
                                'Filter',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  child: Text(
                    'Available Doctors',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                //---------------------------------------doctors list
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchSucess) {
                        return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 130,
                                    //color: Colors.white.withOpacity(0.4),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 100,
                                          height: 135,
                                          //  color: Colors.amber,
                                          // decoration: BoxDecoration(
                                          //     // color: Colors.red,
                                          //     borderRadius:
                                          //         BorderRadius.circular(10),
                                          //     image: DecorationImage(
                                          //         fit: BoxFit.cover,
                                          //         // image: AssetImage(
                                          //         //     'assets/doctor_sample.png')
                                          //         image: NetworkImage(state
                                          //             .doctorList[index]
                                          //             .profilePicture!
                                          //             .secureUrl!))),

                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(state
                                                .doctorList[index]
                                                .profilePicture!
                                                .secureUrl!),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 135,
                                          width: 250,
                                          // color: Colors.amber,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Dr. ${state.doctorList[index].fullName}',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              const Row(
                                                children: [
                                                  //Image(image: NetworkImage(''))
                                                  Icon(
                                                    Icons.medical_information,
                                                    size: 15,
                                                  ),
                                                  Text('Specialiy')
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),

                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  RatingBarIndicator(
                                                    rating: 4,
                                                    itemSize: 18,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return const Icon(
                                                          Icons.star,
                                                          color: Colors.orange);
                                                    },
                                                  ),
                                                 
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 16,
                                                      ),
                                                        Text('Calicut,Kerala',maxLines: 1,)
                                                    ],
                                                  ),
                                                
                                                ],
                                              ),
                                              const Text(' ₹ 500 Rs'),
                                              // ElevatedButton(
                                              //   onPressed: () {
                                              //     //-----------------------------------------booking
                                              //   },
                                              //   child:
                                              //       const Text('Appointment'),
                                              //   style: ButtonStyle(
                                              //       minimumSize:
                                              //           MaterialStateProperty
                                              //               .all<Size>(
                                              //     const Size(10, 20),
                                              //   )),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: state.doctorList.length);
                      } else if (state is SearchFailure) {
                        return Center(
                          child: Text('Not connected to server'),
                        );
                      }

                      return Center(
                        child: Text('No doctors aVALIABLE'),
                      );
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

  // Method to close the keyboard by unfocusing the current focus node.
  void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
