import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/presentation/patient/booking/screen_booking.dart';
import 'package:appoint_medic/presentation/patient/booking/view_doctor_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchByNameWidget extends StatelessWidget {
  const SearchByNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchNameLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchNameSucess) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      //--------------------------------------------------------------navigation to view doctor profile page
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScreenViewDoctorProfileBook(
                              doctor: state.searchNameResults[index]),
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
                                  width: size.width * 0.25,
                                  height: 100,
                                  //  color: Colors.grey.withOpacity(0.3),
                                  child: state.searchNameResults[index]
                                              .profilePicture !=
                                          null
                                      ? Image.network(
                                          state.searchNameResults[index]
                                              .profilePicture!.secureUrl!,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }

                                            return const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Center(
                                                child: Icon(Icons.person));
                                          },
                                        )
                                      : state.searchNameResults[index].gender ==
                                              'female'
                                          ? Image.asset(
                                              'assets/female_doctor.png')
                                          : Image.asset(
                                              'assets/doctor_male.png')
                                  //---------------------------------------------
                                  ),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Container(
                              height: 100,
                              width: size.width * 0.5,
                              //  color: Colors.amber,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.001,
                                  ),
                                  Text(
                                    'Dr.${state.searchNameResults[index].fullName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: size.width * 0.5 * 0.10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.width * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      //Image(image: NetworkImage(''))
                                      const Icon(
                                        Icons.medical_information,
                                        size: 15,
                                      ),
                                      Text(
                                          state.searchNameResults[index]
                                              .speciality!.name!,
                                          style: TextStyle(
                                              fontSize: size.width * 0.028))
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.001,
                                  ),

                                  // const SizedBox(
                                  //   height: 0,
                                  // ),
                                  //-------------------------------------------location & rating
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 15,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            '${state.searchNameResults[index].address?.city ?? 'Trivandrum'},${state.searchNameResults[index].address?.state ?? 'Kerala'}',
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: size.width * 0.028),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 25,
                                    width: 80,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        //-----------------------------------------booking

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (ctx) => ScreenBooking(
                                            doctor:
                                                state.searchNameResults[index],
                                          ),
                                        ));
                                      },
                                      child: const Text('Book'),
                                      style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
                                        const Size(25, 25),
                                      )),
                                    ),
                                  )

                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     //-----------------------------------------booking

                                  //       Navigator.of(context)
                                  //       .push(MaterialPageRoute(
                                  //     builder: (ctx) => ScreenBooking(
                                  //       doctor: state.searchNameResults[index],
                                  //     ),
                                  //   ));
                                  //   },
                                  //   child: const Text('Book'),
                                  //   style: ButtonStyle(
                                  //       minimumSize:
                                  //           MaterialStateProperty.all<Size>(
                                  //     const Size(25, 25),
                                  //   )),
                                  // )
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
              itemCount: state.searchNameResults.length);
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
