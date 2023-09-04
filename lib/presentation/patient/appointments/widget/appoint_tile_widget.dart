import 'dart:developer';

import 'package:appoint_medic/application/chat/create_chat/bloc/create_chat_bloc.dart';
import 'package:appoint_medic/presentation/patient/messages/create_chat/screen_createChat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentListTileWidget extends StatelessWidget {
  const AppointmentListTileWidget({
    super.key,
    required this.size,
    required this.date,
    required this.doctorname,
    required this.startTime,
    required this.endTime,
    required this.speciality,
    required this.doctImageUrl,
    required this.bookingStatus,
    required this.doctorID,
  });

  final Size size;
  final String? date,
      doctorname,
      startTime,
      endTime,
      speciality,
      doctImageUrl,
      bookingStatus;

  final String doctorID;

  @override
  Widget build(BuildContext context) {
    log((size.width * 0.12).toString());
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
          height: size.height * 0.14,
          width: size.width,
          color: Colors.blue.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: size.height * 0.14 * 0.4,
                          width: size.width * 0.15,
                          // color: Colors.amber,
                          child: Image(
                            image: NetworkImage(doctImageUrl!),
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/patient.png');
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        width: size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. $doctorname',
                              style: TextStyle(
                                  fontSize: size.width * 0.7 * 0.07,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(speciality ?? '')
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            //-----------------------------------------------chat intiate
                            log(doctorID);

                            BlocProvider.of<CreateChatBloc>(context)
                                .add(StartChat(userID: doctorID));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ScreenCreateChat(doctorID: doctorID);
                              },
                            ));
                          },
                          icon: const Icon(
                            Icons.message_outlined,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                        ),
                        Text(date!),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 16,
                        ),
                        Text('$startTime - $endTime'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          bookingStatus == 'Approved'
                              ? Icons.verified_user
                              : Icons.pending_actions,
                          size: 16,
                          color: bookingStatus == 'Approved'
                              ? Colors.green
                              : Colors.red,
                        ),
                        Text(
                          bookingStatus!,
                          style: TextStyle(
                              color: bookingStatus == 'Approved'
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}