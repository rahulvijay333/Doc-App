import 'package:appoint_medic/application/Search/search_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/application/speciality/speciality_bloc.dart';
import 'package:appoint_medic/domain/response_models/get_specialities_response/speciality.dart';
import 'package:appoint_medic/presentation/patient/search/screen_search.dart';
import 'package:appoint_medic/presentation/patient/search/screen_speclty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<SearchBloc>(context).add(ShowAllDoctorList());
    BlocProvider.of<SpecialityBloc>(context).add(DisplaySpecialityHome());
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        //-------------------------------------------------1st section
        Container(
          height: size.height * 0.23,
          width: double.maxFinite,
          color: Colors.blue,
          child: Column(
            children: [
              Container(
                height: size.height * 0.14,
                //  color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //welcome
                      SizedBox(
                          //color: Colors.amber,
                          width: size.width * 0.20,
                          height: size.height * 0.15 * 0.80,
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/patient.png'),
                          )),

                      //---------------------------------------name and welcome

                      Container(
                        width: size.width * 0.60,
                        height: size.height * 0.15 * 0.80,
                        //  color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Welcome',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),
                      //------------------------------------------reminder icon
                      SizedBox(
                        height: size.height * 0.15 * 0.50,
                        width: size.width * 0.10,
                        child: CircleAvatar(
                          radius: 21,
                          backgroundColor: Colors.white.withOpacity(0.5),
                          child: CircleAvatar(
                            radius: 19,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //---------------------------------------------search doctors
              GestureDetector(
                onTap: () {
                  //----------------------------search page navigation

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ScreenSearch();
                    },
                  ));

                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //     pageBuilder: (context, animation, secondaryAnimation) {
                  //       // Build the new route/screen here
                  //       return ScreenSearch();
                  //     },
                  //     transitionsBuilder:
                  //         (context, animation, secondaryAnimation, child) {
                  //       // Define your custom transition animation here
                  //       return SlideTransition(
                  //         position: Tween<Offset>(
                  //           begin: const Offset(1.0, 0.0),
                  //           end: Offset.zero,
                  //         ).animate(animation),
                  //         child: child,
                  //       );
                  //     },
                  //   ),
                  // );
                },
                child: Container(
                  height: size.height * 0.09,
                  // /  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.search),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Search doctors ..')
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        // const SizedBox(
        //   height: 15,
        // ),
//---------------------------------------------------------------specility
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: size.height * 0.20,
              width: size.width,
              color: Colors.blue[100],
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose from Specialities',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    Expanded(
                      child: BlocBuilder<SpecialityBloc, SpecialityState>(
                        builder: (context, state) {
                          if (state is SpecialityLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SpecialitySucess) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 25),
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) {
                                                return ScreenSpeciality(
                                                    speciality: state
                                                        .specialityList[index]);
                                              },
                                            ));
                                          },
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: Image.network(state
                                                .specialityList[index]
                                                .specialityImg!
                                                .secureUrl!),
                                          ),
                                        ),
                                        Text(state.specialityList[index].name!)
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 14,
                                    );
                                  },
                                  itemCount: state.specialityList.length),
                            );
                          } else if (state is SpecialityFailure) {
                            return Center(
                              child: Text(state.errorMessage),
                            );
                          }

                          return Center(
                            child: Text('Connectivity error'),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        //------------------------------------------2nd section
        Expanded(
          child: Container(
            width: size.width,
            height: size.height * 0.65,
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  top: size.height * 0.65 * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Appointments',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                                height: 110,
                                color: Colors.blue.withOpacity(0.1),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Date : 24/8/2023'),
                                          Text('Time: 4:00pm')
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      leading: const CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage('assets/doctor.png'),
                                      ),
                                      title: const Text('Doctor Name'),
                                      subtitle:
                                          const Text('Department / speciality'),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.message,
                                            color: Colors.blue,
                                          )),
                                    )
                                  ],
                                )),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: 10),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
