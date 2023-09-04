import 'package:appoint_medic/application/searchByCatergory/search_by_category_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/domain/response_models/get_specialities_response/speciality.dart';
import 'package:appoint_medic/presentation/patient/booking/screen_booking.dart';
import 'package:appoint_medic/presentation/patient/booking/view_doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSpeciality extends StatelessWidget {
  const ScreenSpeciality({super.key, required this.speciality});

  final Speciality speciality;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchByCategoryBloc>(context)
        .add(SearchDoctorBySpeciality(speciality.id!));
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
                  color: appBackGround,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            //-------------------------------------------pop function

                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                      Expanded(
                          child: Text(
                        speciality.name!,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),

                //---------------------------------------doctors list
                Expanded(
                  child:
                      BlocBuilder<SearchByCategoryBloc, SearchByCategoryState>(
                    builder: (context, state) {
                      if (state is SearchByCategoryloading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchByCategorySucess) {
                        return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return ScreenViewDoctorProfileBook(
                                              doctor: state
                                                  .searchCatResults[index]);
                                        },
                                      ));
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 120,
                                      color: const Color.fromARGB(
                                          50, 217, 217, 217),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              width: 100,
                                              height: 110,
                                              color: Colors.grey,
                                              child: Image.network(
                                                state
                                                        .searchCatResults[index]
                                                        .profilePicture
                                                        ?.secureUrl ??
                                                    '',
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;

                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 1,
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  if (state
                                                          .searchCatResults[
                                                              index]
                                                          .gender ==
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
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          Container(
                                            height: 135,
                                            width: 220,
                                            // color: Colors.amber,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Dr. ${state.searchCatResults[index].fullName}',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(state
                                                    .searchCatResults[index]
                                                    .speciality!
                                                    .name!),
                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                // const SizedBox(
                                                //   height: 0,
                                                // ),
                                                //-------------------------------------------location & rating
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 15,
                                                          color: Colors.green,
                                                        ),
                                                        Text(
                                                          'Calicut,Kerala',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                // const Text(' ₹ 500 Rs'),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    //-----------------------------------------booking
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) {
                                                        return ScreenBooking(
                                                            doctor: state
                                                                    .searchCatResults[
                                                                index]);
                                                      },
                                                    ));
                                                  },
                                                  child: const Text('Book'),
                                                  style: ButtonStyle(
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all<Size>(
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
                            itemCount: state.searchCatResults.length);
                      } else if (state is SearchByCategoryFailure) {
                        return Center(
                          child: Text(state.errorMessage),
                        );
                      }

                      return const Center(
                        child: Text('No doctors available'),
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
}
