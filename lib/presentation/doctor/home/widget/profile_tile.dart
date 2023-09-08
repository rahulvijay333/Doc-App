import 'package:appoint_medic/application/notifications/bloc/view_notifications_bloc.dart';
import 'package:appoint_medic/application/notifications/notificationStatus_track/bloc/notification_track_bloc.dart';
import 'package:appoint_medic/presentation/doctor/home/widget/notification.dart';
import 'package:appoint_medic/presentation/doctor/notifications-doc/screeen_notifications_doct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/doctor profile/doctor_profile_model/doctor.dart';

class ProfileTileCustom extends StatelessWidget {
  const ProfileTileCustom({
    super.key,
    required this.size,
   
    required this.doctorDetails,
  });

  final Size size;
  
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
                height: size.width * 0.15 ,
                width: size.width * 0.15 ,
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
                     Text('Welcome,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width*0.6*0.06,
                        )),
                    SizedBox(height: size.height * 0.3 * 0.40 * 0.05),
                    Text('Dr.${doctorDetails.fullName}',
                        style:  TextStyle(
                            color: Colors.white,
                            fontSize: size.width*0.6*0.1,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: size.height * 0.3 * 0.40 * 0.02),
                    Text('${doctorDetails.qualification}',
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: size.width*0.6*0.05,
                        )),
                  ],
                )),

            InkWell(onTap: () {
              context
                  .read<ViewNotificationsBloc>()
                  .add(GetNotifications(notificationUserType: 'doctor'));

              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    // Build the new route/screen here
                    return ScreenNotificationDoct();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Define your custom transition animation here
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            }, child:
                BlocBuilder<NotificationTrackBloc, NotificationTrackState>(
              builder: (context, state) {
                return NotificationBell(
                    notificationCount: state.notificationCount);
              },
            ))
            // IconButton(onPressed: () {

            // }, icon: Icon(Icons.notifications))
          ],
        ),
      ),
    );
  }
}
