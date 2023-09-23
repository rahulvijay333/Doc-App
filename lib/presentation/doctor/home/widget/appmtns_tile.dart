import 'package:appoint_medic/application/chat/create_chat_doct/bloc/create_chat_doc_bloc.dart';
import 'package:appoint_medic/presentation/doctor/messages/create%20_chat/create_chat_doc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ApointTodayTileWidget extends StatelessWidget {
  const ApointTodayTileWidget(
      {super.key,
      required this.size,
      required this.patientName,
      required this.imgUrl,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.patientID,
      required this.reason});

  final Size size;
  final String patientName;
  final String? imgUrl;
  final DateTime date;
  final String startTime, endTime;
  final String patientID;
  final String reason;

  @override
  Widget build(BuildContext context) {
    String formatedDate = DateFormat('dd MMM yyyy').format(date);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        // height: size.height * 0.14,
        width: size.width,
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date : $formatedDate',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: size.width * 0.18,
                      height: size.height * 0.15 * 0.55,
                      //  color: Colors.red,
                      child: imgUrl == null
                          ? Image.asset(
                              'assets/place_holder_patient.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              imgUrl ?? '',
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }

                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/place_holder_patient.png',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          patientName,
                          maxLines: 1,
                          style:  TextStyle(fontSize: size.width*0.05 * 1.2),
                        ),
                        const Divider(thickness: 0.1,
                          color: Colors.grey,
                        ),
                        Text('Time : $startTime - $endTime',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Container(
                   
                    child: Column(
                   
                      children: [
                        IconButton(
                            onPressed: () {
                              //-----------------------------------chat function
                              BlocProvider.of<CreateChatDocBloc>(context)
                                  .add(StartChat(userID: patientID));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const ScreenCreateChatDoc();
                                },
                              ));
                            },
                            icon: const Icon(
                              Icons.chat,
                              color: Colors.blue,
                            )),
                        IconButton(
                            onPressed: () {
                              //show reason for booking
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Medical Reason',
                                    ),
                                    content: Text(
                                      reason,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
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
                            icon: const Icon(Icons.info_outline,
                                color: Colors.blue))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
