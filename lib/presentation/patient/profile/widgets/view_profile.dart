import 'package:appoint_medic/application/profile/profile_details_bloc.dart';
import 'package:appoint_medic/domain/response_models/profile_model/user.dart';
import 'package:appoint_medic/presentation/patient/profile/widgets/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenPersonalDetails extends StatelessWidget {
  const ScreenPersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
          builder: (context, state) {
            if (state is ProfileSucess) {
              return Column(
                children: [
                  ProfileAppBar(
                    size: size,
                    patientDetails: state.userProfile.user!,
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
                              child: state.userProfile.user?.profilePicture ==
                                      null
                                  ? Image.asset('assets/patient.png')
                                  : Image.network(
                                      state.userProfile.user!.profilePicture!
                                          .secureUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/place_holder_patient.png');
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          // height: size.height * 0.15,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.userProfile.user!.fullName ?? state.userProfile.user!.name}',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.width * 0.02,
                                ),
                                Text(
                                  'Gender: ${state.userProfile.user?.gender ?? 'Not Set'} ',
                                  style: TextStyle(),
                                ),
                                SizedBox(
                                  height: size.width * 0.02,
                                ),
                                Text(
                                    'Address : ${state.userProfile.user!.address?.houseName ?? "Not Set"} ${state.userProfile.user!.address?.city ?? ""} ${state.userProfile.user!.address?.state ?? ""}'),
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
                          // height: size.height * 0.10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Text('Age : ${doct.gender}'),
                                Text(
                                    'Phone : ${state.userProfile.user!.phone ?? "Not set"}'),
                                SizedBox(
                                  height: size.width * 0.02,
                                ),
                                Text(
                                    'Email : ${state.userProfile.user!.email}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is ProfileLoading) {
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

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    required this.size,
    required this.patientDetails,
  });

  final Size size;
  final User patientDetails;

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
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) {
                //     return ScreenEditProfDoct(
                //       image: doctDetails.profilePicture!.secureUrl ?? '',
                //       houseName: doctDetails.address!.houseName!,
                //       city: doctDetails.address!.city!,
                //       state: doctDetails.address!.state!,
                //       service: doctDetails.services!,
                //       id: doctDetails.id!,
                //     );
                //   },
                // ));

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ScreenPatientEdit(
                      userDetails: patientDetails,
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

// class ScreenPersonalDetails extends StatelessWidget {
//   const ScreenPersonalDetails({super.key, required this.user});
//   final ProfileModel user;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Container(
//             width: 150,
//             height: 150,
//             color: Colors.red,
//             child: CircleAvatar(
//               backgroundImage:
//                   NetworkImage(user.user!.profilePicture!.secureUrl!),
//             ),
//           ),
//           Text('Name : ${user.user!.name}'),
//           Text('Age : ${user.user!.gender} '),
//           Text('Email :  ${user.user!.email}'),
//           Text('Address'),
//           Text(user.user!.address!.toString())
//         ],
//       ),
//     );
//   }
// }
