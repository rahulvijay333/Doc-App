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
    final size = MediaQuery.of(context).size;

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
                                  width: size.width * 0.24,
                                  height: 100,
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
                                                color: Colors.blue,
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
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Container(
                              height: 100,
                              width: size.width * 0.5,
                              // color: Colors.amber,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dr. ${state.doctorList[index].fullName}',
                                    maxLines: 1,
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
                                      SizedBox(
                                        height: size.width * 0.01,
                                      ),
                                      Text(
                                        state.doctorList[index].speciality!
                                            .name!,
                                        style: TextStyle(
                                            fontSize: size.width * 0.028),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 0.01,
                                  ),
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
                                          SizedBox(
                                            height: size.width * 0.01,
                                          ),
                                          Text(
                                            '${state.doctorList[index].address?.city ?? 'Trivandrum'},${state.doctorList[index].address?.state ?? 'Kerala'}',
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: size.width * 0.028),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.width * 0.01,),
                                  Container(
                                    height: 25,
                                    width: 80,
                                    // color: Colors.red,
                                    child:    ElevatedButton(
                                    onPressed: () {
                                      //-----------------------------------------booking
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => ScreenBooking(
                                          doctor: state.doctorList[index],
                                        ),
                                      ));
                                    },
                                    child: Text(
                                      'Book',
                                      style: TextStyle(
                                          fontSize: size.width * 0.03),
                                    ),
                                    style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                      const Size(25, 25),
                                    )),
                                  ),
                                  
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
                  height: 10,
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
