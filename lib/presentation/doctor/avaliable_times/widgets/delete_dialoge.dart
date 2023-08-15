import 'dart:developer';

import 'package:appoint_medic/application/slot/appointment_slot_bloc.dart';
import 'package:appoint_medic/presentation/doctor/avaliable_times/screen_avalibale_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteSlotDialoge extends StatelessWidget {
  final BuildContext contextAT;
  final String slotID;
  final String mainSlotID;
  final String token;
  final String date;

  const DeleteSlotDialoge(
      {super.key,
      required this.contextAT,
      required this.slotID,
      required this.mainSlotID,
      required this.token,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Important'),
      content: const Text('Do you want to delete slot ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<AppointmentSlotBloc>().add(deleteSlotEvent(
                mainSlotID: mainSlotID,
                slotID: slotID,
                token: token,
                date: date,
                context: contextAT));

            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
