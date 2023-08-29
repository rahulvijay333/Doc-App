import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentTileCustom extends StatelessWidget {
  const AppointmentTileCustom({
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
                      isDoctorApproved
                          ? const Text(
                              'Approved',
                              style: TextStyle(color: Colors.green),
                            )
                          : const Text(
                              'Cancelled',
                              style: TextStyle(color: Colors.red),
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
