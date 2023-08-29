import 'package:appoint_medic/presentation/doctor/home/widget/notification.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/doctor profile/doctor_profile_model/doctor.dart';

class ProfileTileCustom extends StatelessWidget {
  const ProfileTileCustom({
    super.key,
    required this.size,
    required this.name,
    required this.doctorDetails,
  });

  final Size size;
  final String name;
  final Doctor doctorDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.red,
      width: size.width,
      height: size.height * 0.3 * 0.50,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: size.height * 0.3 * 0.30,
                width: size.height * 0.3 * 0.30,
                child: Image.network(
                  doctorDetails.profilePicture!.secureUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
                height: size.height * 0.3 * 0.30,
                width: size.width * 0.6,
                //  color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Welcome,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    SizedBox(height: size.height * 0.3 * 0.40 * 0.05),
                    Text('Dr.${doctorDetails.fullName}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: size.height * 0.3 * 0.40 * 0.02),
                    Text('${doctorDetails.qualification}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        )),
                  ],
                )),

            NotificationBell(notificationCount: 5)
            // IconButton(onPressed: () {

            // }, icon: Icon(Icons.notifications))
          ],
        ),
      ),
    );
  }
}
