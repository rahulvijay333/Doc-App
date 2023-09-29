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
    required this.reason
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
  final String reason;

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
                      // height: size.width * 0.16,
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
                    child: Center(
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
               SizedBox(
                width: size.width*0.01,
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
                        style:  TextStyle(
                            fontSize: size.width * 0.05, fontWeight: FontWeight.w500),
                      ),
                      Text(emailID,
                          style: TextStyle(
                             fontSize: size.width*0.03,
                              color: Colors.black.withOpacity(0.5))),
                       SizedBox(
                         height: size.width*0.02,
                      ),
                      Text('Slot : $startTime - $endTime', style:  TextStyle(
                            fontSize: size.width * 0.035)),
                       SizedBox(
                          height: size.width*0.02,
                      ),
                      //---------------------condition here
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                           
                              //---------------------------approve
                              context
                                  .read<ViewAppointmentsDoctSideBloc>()
                                  .add(ApproveBookingCall(bookID));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 28,
                                width: size.width * 0.15,
                                color: Colors.green,
                                child:  Center(
                                    child: Text('Accept',
                                        style: TextStyle(color: Colors.white,fontSize: size.width * 0.15 *0.2))),
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
                               width: size.width * 0.15,
                                color: Colors.red,
                                child:  Center(
                                    child: Text(
                                  'cancel',
                                  style: TextStyle(color: Colors.white,fontSize: size.width * 0.15 *0.2),
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
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          //------------------------------------------message function
                          BlocProvider.of<CreateChatDocBloc>(context)
                              .add(StartChat(userID: patientID));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const ScreenCreateChatDoc();
                            },
                          ));
                        },
                        icon: const Icon(
                          Icons.message_outlined,
                          color: Colors.blue,
                        )),
                          IconButton(
                        onPressed: () {
                          //show reason for booking
                             showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Medical Reason'),
                                content: Text(
                                  reason.isEmpty ? "NA" : reason,
                                  maxLines: 3,style: TextStyle(color: Colors.black.withOpacity(0.5))
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'))
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.info_outline, color: Colors.blue))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
