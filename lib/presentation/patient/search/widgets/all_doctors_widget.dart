import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorWidget extends StatelessWidget {
  const AllDoctorWidget({super.key});

  @override
  Widget build(BuildContext context) {
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

                            //color: Colors.red,
                            // child: CircleAvatar(
                            //   backgroundImage: NetworkImage(state
                            //       .doctorList[index]
                            //       .profilePicture!
                            //       .secureUrl!),
                            // ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    // image: NetworkImage(state
                                    //     .doctorList[index]
                                    //     .profilePicture!
                                    //     .secureUrl!)
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
                                  'Dr. ${state.doctorList[index].fullName}',
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
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

        return Center(
          child: Column(
            children: [
              const Text('No doctors available'),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<SearchBloc>(context)
                        .add(ShowAllDoctorList());
                  },
                  child: const Text('Retry'))
            ],
          ),
        );
      },
    );
  }
}
