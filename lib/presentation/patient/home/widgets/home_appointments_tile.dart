import 'package:appoint_medic/application/chat/create_chat/bloc/create_chat_bloc.dart';
import 'package:appoint_medic/presentation/patient/messages/create_chat/screen_createChat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeAppointmentsTile extends StatelessWidget {
  const HomeAppointmentsTile({
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
  final DateTime date;
  final Size size;
  final String doctorname,
      startTime,
      endTime,
      speciality,
      doctImageUrl,
      bookingStatus,
      doctorID;
  @override
  Widget build(BuildContext context) {
    String formatedDate = DateFormat('dd MMM yyyy').format(date);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
          height: 110,
          color: Colors.blue.withOpacity(0.1),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date : $formatedDate'),
                    Text('Time: $startTime - $endTime')
                  ],
                ),
              ),
              ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(doctImageUrl),
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
                    )),
                title: Text("Dr.$doctorname"),
                subtitle: Text(speciality),
                trailing: IconButton(
                    onPressed: () {
                      //--------------------------------------------------chat function
                      BlocProvider.of<CreateChatBloc>(context)
                          .add(StartChat(userID: doctorID));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ScreenCreateChat(doctorID: doctorID);
                        },
                      ));
                    },
                    icon: const Icon(
                      Icons.message,
                      color: Colors.blue,
                    )),
              )
            ],
          )),
    );
  }
}
