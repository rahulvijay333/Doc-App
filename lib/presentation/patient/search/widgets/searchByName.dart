import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/presentation/patient/booking/screen_booking.dart';
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
                      //--------------------------------------------------------------navigation to booking page
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScreenBooking(
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
                            Container(
                              width: 100,
                              height: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/doctor_sample.png'))),
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
                                    'Dr. ${state.searchNameResults[index].fullName}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
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
                                    ],
                                  ),

                                  ElevatedButton(
                                    onPressed: () {
                                      //-----------------------------------------booking
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
