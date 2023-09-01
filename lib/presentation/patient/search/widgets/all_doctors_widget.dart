import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/presentation/patient/booking/screen_booking.dart';
import 'package:appoint_medic/presentation/patient/booking/view_doctor_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorWidget extends StatelessWidget {
  const AllDoctorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<SearchBloc>(context).add(ShowAllDoctorList());
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchSucess) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    //-------------------------------------------------------------------navigation to appointment
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (ctx) => ScreenBooking(
                        //     doctor: state.doctorList[index],
                        //   ),
                        // ));
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ScreenViewDoctorProfileBook(
                              doctor: state.doctorList[index],
                            );
                          },
                        ));
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 120,
                        color: const Color.fromARGB(50, 217, 217, 217),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  width: 100,
                                  height: 110,
                                  color: Colors.grey,
                                  child: state.doctorList[index]
                                              .profilePicture !=
                                          null
                                      ? Image.network(
                                          state.doctorList[index]
                                              .profilePicture!.secureUrl!,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;

                                            return const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            if (state
                                                    .doctorList[index].gender ==
                                                'female') {
                                              return Image.asset(
                                                'assets/female_doctor.png',
                                                fit: BoxFit.cover,
                                              );
                                            } else {
                                              return Image.asset(
                                                'assets/doctor_male.png',
                                                fit: BoxFit.cover,
                                              );
                                            }
                                          },
                                        )
                                      : state.doctorList[index].gender ==
                                              'female'
                                          ? Image.asset(
                                              'appoint_medic/assets/female_doctor.png',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/doctor_male.png",
                                              fit: BoxFit.cover,
                                            )),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Container(
                              height: 135,
                              width: 220,
                              // color: Colors.amber,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dr. ${state.doctorList[index].fullName}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      //Image(image: NetworkImage(''))
                                      const Icon(
                                        Icons.medical_information,
                                        size: 15,
                                      ),
                                      Text(state
                                          .doctorList[index].speciality!.name!)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // const SizedBox(
                                  //   height: 0,
                                  // ),
                                  //-------------------------------------------location & rating
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 15,
                                          ),
                                          Text(
                                            'Calicut,Kerala',
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                      // RatingBarIndicator(
                                      //   rating: 4,
                                      //   itemSize: 18,
                                      //   itemBuilder:
                                      //       (context, index) {
                                      //     return const Icon(
                                      //         Icons.star,
                                      //         color: Colors.orange);
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  // const Text(' ₹ 500 Rs'),
                                  ElevatedButton(
                                    onPressed: () {
                                      //-----------------------------------------booking
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => ScreenBooking(
                                          doctor: state.doctorList[index],
                                        ),
                                      ));
                                    },
                                    child: const Text('Book'),
                                    style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                      const Size(25, 25),
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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
          return const Center(
            child: Text('Not connected to server'),
          );
        }

        return const Center(
          child: Text('No doctors available'),
        );
      },
    );
  }
}
