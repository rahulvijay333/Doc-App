import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/domain/response_models/get_specialities_response/speciality.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSpeciality extends StatelessWidget {
  const ScreenSpeciality({super.key, required this.speciality});

  final Speciality speciality;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchBloc>(context)
        .add(SearchByFilter(speciality: speciality.id));
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
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 15, bottom: 15, top: 20, right: 15),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: Container(
                //       color: Colors.grey.withOpacity(0.1),
                //       child: TextFormField(
                //         cursorColor: Colors.grey,
                //         decoration: const InputDecoration(
                //             suffixIcon: Icon(
                //               Icons.filter_alt,
                //               color: Colors.grey,
                //             ),
                //             prefixIcon: Icon(
                //               Icons.search,
                //               color: Colors.grey,
                //             ),
                //             hintText: 'Search by name',
                //             border: InputBorder.none,
                //             hintStyle: TextStyle(
                //               color: Colors.grey,
                //               fontSize: 15,
                //             )),
                //       ),
                //     ),
                //   ),
                // ),
                //---------------------------------------doctors list
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchFilterLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchFilterSuccess) {
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
                                    height: 120,
                                    color:
                                        const Color.fromARGB(50, 217, 217, 217),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Dr. ${state.searchFilterResults[index].fullName}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        style: TextStyle(
                                                            fontSize: 12),
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
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: state.searchFilterResults.length);
                      } else if (state is SearchFilterFailure) {
                        return Center(
                          child: Text(state.errorFilterMessage),
                        );
                      }

                      return Center(
                        child: Column(
                          children: [
                            const Text('No doctors available'),
                            TextButton(
                                onPressed: () {
                                  // BlocProvider.of<SearchBloc>(context)
                                  //     .add(ShowAllDoctorList());
                                },
                                child: const Text('Retry'))
                          ],
                        ),
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
