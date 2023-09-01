import 'dart:developer';

import 'package:appoint_medic/application/chat/create_chat_doct/bloc/create_chat_doc_bloc.dart';
import 'package:appoint_medic/application/view_appointments_doctor/bloc/view_appointments_doct_side_bloc.dart';
import 'package:appoint_medic/presentation/doctor/messages/create%20_chat/create_chat_doc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    super.key,
    required this.patientName,
    required this.emailID,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isDoctorApproved,
    required this.patientImage,
    required this.bookID,
    required this.isCancelled,
    required this.patientID,
  });

  final String patientName;
  final String emailID;
  final DateTime? date;
  final String startTime;
  final String endTime;
  final String patientImage;
  final bool isDoctorApproved;
  final bool isCancelled;
  final String bookID;
  final String patientID;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //--------------formating date
    String formatedDate = '';

    if (date == null) {
      formatedDate = '';
    } else {
      formatedDate = DateFormat('dd MMM yyyy').format(date!);
    }

    //---------------------<<<<<----------------
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 120,
        width: double.maxFinite,
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: size.width * 0.16,
                      width: size.width * 0.16,
                      child: Image.network(
                        patientImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    //  color: Colors.red,
                    width: size.width * 0.24,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formatedDate,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.24 * 0.13),
                      ),
                    ),
                  )
                ],
              ),
              const VerticalDivider(color: Colors.grey),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  // color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patientName,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(emailID,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.5))),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Slot : $startTime - $endTime'),
                      const SizedBox(
                        height: 10,
                      ),
                      //---------------------condition here
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              log('pressed accept from pending page');
                              //---------------------------approve
                              context
                                  .read<ViewAppointmentsDoctSideBloc>()
                                  .add(ApproveBookingCall(bookID));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 28,
                                width: 80,
                                color: Colors.green,
                                child: const Center(
                                    child: Text('Accept',
                                        style: TextStyle(color: Colors.white))),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //---------------------------------------------------cancel
                              context
                                  .read<ViewAppointmentsDoctSideBloc>()
                                  .add(CancelBookingCall(bookID));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 28,
                                width: 80,
                                color: Colors.red,
                                child: const Center(
                                    child: Text(
                                  'cancel',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: IconButton(
                    onPressed: () {
                      //------------------------------------------message function
                      BlocProvider.of<CreateChatDocBloc>(context)
                          .add(StartChat(userID: patientID));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ScreenCreateChatDoc();
                        },
                      ));
                    },
                    icon: Icon(
                      Icons.message_outlined,
                      color: Colors.blue,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
