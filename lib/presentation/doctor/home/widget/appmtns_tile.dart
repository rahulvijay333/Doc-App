import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApointTodayTileWidget extends StatelessWidget {
  const ApointTodayTileWidget({
    super.key,
    required this.size,
    required this.patientName,
    required this.imgUrl,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.patientID,
  });

  final Size size;
  final String patientName;
  final String? imgUrl;
  final DateTime date;
  final String startTime, endTime;
  final String patientID;

  @override
  Widget build(BuildContext context) {
    String formatedDate = DateFormat('dd MMM yyyy').format(date);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: size.height * 0.14,
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
                      // color: Colors.red,
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
                  Container(
                    width: size.width * 0.55,
                    // color: Colors.green,
                    height: size.height * 0.15 * 0.60,
                    child: Column(
                      children: [
                        Text(
                          patientName,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 22),
                        ),
                        Divider(),
                        Text('Time : $startTime - $endTime',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.grey,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chat,
                          color: Colors.blue,
                        )),
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
