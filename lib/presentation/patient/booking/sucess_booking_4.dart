import 'package:appoint_medic/application/booking/patientTrackBooking/bloc/booking_tracker_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/patient/booking/screen_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//----------------------------------------------------------------appoint last page
class ScreenSuccessPayment extends StatelessWidget {
  const ScreenSuccessPayment({super.key, e});
  // final String date;
  // final String doctorName;
  // final String startTime, endTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: size.height * 0.07,
              width: size.width,
              color: appBackGround,
              child:  Center(
                child: Text(
                  'Payment Status',
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BookingTrackerBloc, BookingTrackerState>(
                builder: (context, state) {
                  //----------------------------------------------------------loading
                  if (state is BookingStatusLoading) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Verifying payment with server , please wait '),
                          SizedBox(
                            height: 5,
                          ),
                          CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ],
                      ),
                    );
                  } else if (state is BookingSucess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          
                          'assets/payment_2.gif',
                          height:size.width * 0.30,
                          width: size.width * 0.30,
                          fit: BoxFit.cover,
                          
                        ),
                        TextCustomWidget(
                          size: size,
                          title: 'Appointment Booking Successfull',
                          fontweight: FontWeight.w500,
                          sizeValue: 0.05,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: size.height * 0.15,
                            width: size.width * 0.6,
                            color: Colors.blue.withOpacity(0.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextCustomWidget(
                                    size: size,
                                    title: state.date,
                                    fontweight: FontWeight.w400,
                                    sizeValue: 0.04),
                                TextCustomWidget(
                                    size: size,
                                    title: 'Dr. ${state.doct.fullName}',
                                    fontweight: FontWeight.w500,
                                    sizeValue: 0.04),
                                TextCustomWidget(
                                    size: size,
                                    title:
                                        '${state.bookingDetails.appointment!.startTime} - ${state.bookingDetails.appointment!.endTime}',
                                    fontweight: FontWeight.w400,
                                    sizeValue: 0.03),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          width: size.width * 0.30,
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<BookingTrackerBloc>(context)
                                    .add(BookingTrackClear());
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              },
                              child: Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: size.width * 0.30 * 0.13),
                              )),
                        )
                      ],
                    );
                  } else if (state is BookingFailed) {
                    return Center(
                      child: Text(
                          'Appointment booking unsuccessfull , Please try again lator'),
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextCustomWidget extends StatelessWidget {
  const TextCustomWidget({
    super.key,
    required this.size,
    required this.title,
    required this.fontweight,
    required this.sizeValue,
  });
  final String title;
  final FontWeight fontweight;
  final num sizeValue;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          TextStyle(fontSize: size.width * sizeValue, fontWeight: fontweight),
    );
  }
}
