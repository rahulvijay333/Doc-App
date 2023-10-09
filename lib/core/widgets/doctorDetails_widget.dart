import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorTileWidget extends StatelessWidget {
  const DoctorTileWidget(
      {super.key,
      required this.doctorName,
      required this.specialityName,
      required this.date,
      required this.size,
      this.imageUrl,
      required this.gender,
      required this.starttime,
      required this.endTime});
  final String doctorName;
  final String specialityName;
  final String date;
  final String starttime;
  final String endTime;
  final Size size;

  final String? imageUrl;
  final String gender;

  String formatDate(String inputDate) {
    final dateTime = DateTime.parse(inputDate);
    final formattedDate = DateFormat('d MMM, y').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      height: size.height * 0.20,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            //---------------------------------------------image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: size.height * 0.12,
                width: 100,
                child: Image.network(imageUrl ?? '', fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }, errorBuilder: (context, error, stackTrace) {
                  if (gender == 'female') {
                    return Image.asset(
                      'assets/female_doctor.png',
                      fit: BoxFit.cover,
                    );
                  } else {
                    return Image.asset(
                      'assets/doctor_male.png',
                      fit: BoxFit.cover,
                    );
                  }
                }),
              ),
            ),
             SizedBox(
              width: size.width*0.03,
            ),
            //--------------------------------------
            Expanded(
              child: Container(
                //  color: Colors.amber,
                height: size.height * 0.14,
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr.$doctorName',
                      style:  TextStyle(
                          fontSize: size.width * 0.05, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      specialityName, style:  TextStyle(
                          fontSize: size.width * 0.035)
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      children: [
                         Text(
                          'Date :',
                          style: TextStyle(  fontSize: size.width * 0.035,),
                        ),
                        Text(
                          formatDate(date),
                          style:  TextStyle(color: Colors.blue,fontSize: size.width * 0.035),
                        )
                      ],
                    ),
                    Row(
                      children: [
                         Text(
                          'Time :',
                          style: TextStyle(fontSize: size.width * 0.035),
                        ),
                        Text(
                          '${starttime} - ${endTime}',
                          maxLines: 1,
                          style:  TextStyle(color: Colors.blue,fontSize: size.width * 0.035),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
