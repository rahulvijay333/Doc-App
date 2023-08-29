import 'package:appoint_medic/application/doctor%20profile/bloc/doctor_profile_bloc.dart';
import 'package:appoint_medic/presentation/doctor/profile/widget/edit_profile.dart';
import 'package:appoint_medic/presentation/doctor/profile/widget/pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/doctor profile/doctor_profile_model/doctor.dart';

class ScreenViewPersonalDetails extends StatelessWidget {
  const ScreenViewPersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileSuccess) {
              return Column(
                children: [
                  ProfileAppBar(
                    size: size,
                    doctDetails: state.doctDetails,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          //--------------------------------------------------profile picture here
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              // color: Colors.amber,
                              height: size.height * 0.25,
                              width: size.width * 0.50,
                              child: Image.network(
                                state.doctDetails.profilePicture!.secureUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          height: size.height * 0.15,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. ${state.doctDetails.fullName}',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    'Speciality : ${state.doctDetails.speciality?.name! ?? 'NA'}'),
                                Text(
                                    'Address : ${state.doctDetails.address?.houseName} ,${state.doctDetails.address?.city} ,${state.doctDetails.address?.state}'),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Contact ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: size.height * 0.10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Text('Age : ${doct.gender}'),
                                Text('Phone : ${state.doctDetails.phone}'),
                                Text('Email : ${state.doctDetails.email}'),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Certificates ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: InkWell(
                            onTap: () {
                              if (state.doctDetails.certificate == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text('Certificate not uploaded'),
                                  behavior: SnackBarBehavior.floating,
                                ));
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfViewerScreen(
                                    pdfPath: state
                                        .doctDetails.certificate!.secureUrl!,
                                  ),
                                ),
                              );
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.book),
                                SizedBox(
                                  width: 2,
                                ),
                                Text('View Certificate'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is DoctorProfileLoading) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return const Center(
                child: Text('Offline'),
              );
            }
          },
        ),
      ),
    );
  }
}

// class TextFieldCustom extends StatelessWidget {
//   const TextFieldCustom({
//     super.key,
//     required this.title,
//     required this.value,
//   });

//   final String title;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       '$title : $value',
//       style: const TextStyle(fontSize: 22),
//     );
//   }
// }

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    required this.size,
    required this.doctDetails,
  });

  final Size size;
  final Doctor doctDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.07,
      width: size.width,
      color: Colors.blue,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                //----------------------------------------function
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          const Text(
            'Profile',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                //-----------------------------------editing screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ScreenEditProfDoct(
                      image: doctDetails.profilePicture!.secureUrl ?? '',
                      houseName: doctDetails.address!.houseName!,
                      city: doctDetails.address!.city!,
                      state: doctDetails.address!.state!,
                      service: doctDetails.services!,
                      id: doctDetails.id!,
                    );
                  },
                ));
              },
              icon: const Icon(
                Icons.edit_square,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
