import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/application/Payment/payment_bloc.dart';
import 'package:appoint_medic/application/booking/patientTrackBooking/bloc/booking_tracker_bloc.dart';
import 'package:appoint_medic/application/profile/profile_details_bloc.dart';

import 'package:appoint_medic/core/widgets/doctorDetails_widget.dart';
import 'package:appoint_medic/domain/models/bookingDetails/booking_details.dart';
import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/domain/response_models/profile_model/user.dart';
import 'package:appoint_medic/infrastructure/key_razor/razor_pay_key.dart';

import 'package:appoint_medic/presentation/patient/booking/sucess_booking_4.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class ScreenConfirmBooking extends StatefulWidget {
  ScreenConfirmBooking(
      {super.key, required this.bookingdetails, required this.doc});

  final BookingDetails bookingdetails;
  final Doctor doc;

  @override
  State<ScreenConfirmBooking> createState() => _ScreenConfirmBookingState();
}

class _ScreenConfirmBookingState extends State<ScreenConfirmBooking> {
  User? profileDetails;

  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    log('payemnt sucess');

    final details = BookingDetails(
        doctorID: widget.bookingdetails.doctorID,
        dateID: widget.bookingdetails.dateID,
        slotID: widget.bookingdetails.slotID,
        startTime: widget.bookingdetails.startTime,
        endTime: widget.bookingdetails.endTime,
        date: widget.bookingdetails.date,
        fees: widget.bookingdetails.fees,
        orderID: widget.bookingdetails.orderID,
        paymentid: response.paymentId);

    if (details.orderID != null && details.paymentid != null) {
      // log('did : ${widget.bookingdetails.doctorID}, dateid : ${widget.bookingdetails.dateID}, slotid : ${widget.bookingdetails.slotID} ,  startd : ${state.bookingDetails.startTime}, end ;${state.bookingDetails.endTime},fees : ${state.bookingDetails.fees},orderid : ${state.bookingDetails.orderID}, paymn : ${response.paymentId}');
      //--------------------------------------------------final appointment bloc call
      context.read<BookingTrackerBloc>().add(BookingSucessPayment(
          bookingdetails: details,
          patientDetails: profileDetails!,
          doctor: widget.doc));
      context.read<PaymentBloc>().add(PaymentButtonStopLoading());

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const ScreenSuccessPayment();
        },
      ));
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('payemnt failed due to error ${response.message}');
    //------------------------------------------------------------------------stop paybutton loading
    context.read<PaymentBloc>().add(PaymentButtonStopLoading());

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        content: Text(response.message.toString())));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('some error');

    context.read<PaymentBloc>().add(PaymentButtonStopLoading());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //------------------------------------------------appa bar
            Container(
              height: size.height * 0.07,
              width: size.width,
              color: Colors.blue,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        //-------------------------------------------pop function
                        context
                            .read<BookingTrackerBloc>()
                            .add(BookingTrackClear());
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                  const Text(
                    'Confirm',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Doctor details',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DoctorTileWidget(
                    doctorName: widget.doc.fullName!,
                    specialityName: widget.doc.speciality!.name!,
                    date: widget.bookingdetails.date,
                    starttime: widget.bookingdetails.startTime,
                    endTime: widget.bookingdetails.endTime,
                    size: size,
                    gender: widget.doc.gender!,
                    imageUrl: widget.doc.profilePicture!.secureUrl,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Patient details',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //-------------------------------------------------------------patient details
                  BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
                    builder: (context, state) {
                      if (state is ProfileSucess) {
                        //------------------------------------------profile details
                        profileDetails = state.userProfile.user!;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.blue.withOpacity(0.2),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(state
                                        .userProfile
                                        .user!
                                        .profilePicture!
                                        .secureUrl!),
                                  ),
                                  title:
                                      Text(state.userProfile.user!.fullName!),
                                  subtitle:
                                      Text(state.userProfile.user!.email!),
                                )),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //---------------------------------------------------------payment
                  const Text(
                    'Payment details',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Consultation Fee '),
                            Text('${widget.doc.speciality!.fees.toString()} Rs')
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Amount to pay '),
                            Text('${widget.doc.speciality!.fees.toString()} Rs')
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                      height: 40,
                      width: 120,
                      child: BlocBuilder<PaymentBloc, PaymentState>(
                        builder: (context, state) {
                          if (state is PayButtonStartLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ElevatedButton(
                              onPressed: () async {
                                final connectivityResult =
                                    await (Connectivity().checkConnectivity());

                                if (connectivityResult ==
                                        ConnectivityResult.wifi ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  context
                                      .read<PaymentBloc>()
                                      .add(PaymentButtonLoading());
                                  try {
                                    var options = {
                                      'key': razor_key,
                                      'order_id': widget.bookingdetails.orderID,
                                      'amount':
                                          ((widget.doc.speciality!.fees)! *
                                              100), // Amount in paise
                                      'name': 'DocCure',
                                      'description':
                                          'Dr.${widget.doc.fullName}',
                                      'prefill': {
                                        'contact': profileDetails!.phone,
                                        'email': profileDetails!.email
                                      },
                                      'external': {
                                        'wallets': [
                                          'paytm'
                                        ] // List of allowed wallets
                                      }
                                    };
                                    _razorpay.open(options);
                                  } on SocketException catch (e) {
                                    // Handle socket-related exceptions (no network connectivity)
                                    log('SocketException: $e');
                                  } on FormatException catch (e) {
                                    // Handle format-related exceptions (e.g., parsing JSON)
                                    log('FormatException: $e');
                                  } catch (e) {
                                    // Handle other exceptions
                                    log('Exception: $e');
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(15),
                                          content: Text(
                                              'Check internet connection')));
                                }
                              },
                              child: const Text('Pay'),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
