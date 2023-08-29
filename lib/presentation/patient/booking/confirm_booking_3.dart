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
                                context
                                    .read<PaymentBloc>()
                                    .add(PaymentButtonLoading());
                                try {
                                  var options = {
                                    'key': razor_key,
                                    'order_id': widget.bookingdetails.orderID,
                                    'amount': ((widget.doc.speciality!.fees)! *
                                        100), // Amount in paise
                                    'name': 'DocCure',
                                    'description':
                                        'Consultation Fee : ${widget.doc.fullName}',
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

// class ScreenConfirmBooking extends StatelessWidget {
//   ScreenConfirmBooking({super.key});

//   final Razorpay _razorpay = Razorpay();

//   @override
//   Widget build(BuildContext contextScaffold) {
//     User? profilePatientDetails;
//     BookingDetails? bookingDetails;
//     Doctor? doct;
//     final size = MediaQuery.of(contextScaffold).size;
//     log('confirm bokking');
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: BlocBuilder<BookingTrackerBloc, BookingTrackerState>(
//             builder: (context, state) {
//               if (state is Bookingloading) {
//                 return Container(
//                   height: size.height,
//                   child: const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Initializing payment'),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         CircularProgressIndicator(
//                           strokeWidth: 1,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               } else if (state is BookingStatusLoading) {
//                 return Container(
//                   height: size.height,
//                   child: const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Verifying payment'),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         CircularProgressIndicator(
//                           strokeWidth: 1,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               } else if (state is BookingSucess) {
//                 //--------------------------------------------------------------------------------booking success
//                 log('booking sucess');
//                 WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) {
//                       return ScreenSuccessPayment(
//                         doctorName: state.doct.fullName!,
//                         date: state.date,
//                         endTime: state.bookingDetails.appointment!.endTime!,
//                         startTime: state.bookingDetails.appointment!.startTime!,
//                       );
//                     },
//                   ));
//                 });
//               } else if (state is BookingFailed) {
//                 //---------------------------------------------------------------------------------booking failed
//                 log('booking failed');
//               } else if (state is BookingGotOrderID) {
//                 //--------------------------------------------------------------------------------confirmation details
//                 bookingDetails = state.bookingDetails;
//                 doct = state.doct;
// //-------------------------------------------------------------------comment delete
//                 // log(
//                 //   'dateid :${state.bookingDetails.dateID} , doctid : ${state.bookingDetails.doctorID}, orderid : ${state.bookingDetails.orderID} ,startend : ${state.bookingDetails.startTime} ,  endtime ${state.bookingDetails.endTime} ',
//                 // );
//                 return Column(
//                   children: [
//                     AppbarCustomSize(size: size, title: 'Confirmation'),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           //---------------------------------------------------------------doctor details
//                           const Text(
//                             'Doctor details',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           DoctorTileWidget(
//                             doctorName: state.doct.fullName!,
//                             specialityName: state.doct.speciality!.name!,
//                             date: state.bookingDetails.date,
//                             starttime: state.bookingDetails.startTime,
//                             endTime: state.bookingDetails.endTime,
//                             size: size,
//                             gender: state.doct.gender!,
//                             imageUrl: state.doct.profilePicture!.secureUrl,
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           const Text(
//                             'Patient details',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           //-------------------------------------------------------------patient details
//                           BlocBuilder<ProfileDetailsBloc, ProfileDetailsState>(
//                             builder: (context, state) {
//                               if (state is ProfileSucess) {
//                                 //------------------------------------------profile details
//                                 profilePatientDetails = state.userProfile.user!;
//                                 return ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Container(
//                                     color: Colors.blue.withOpacity(0.2),
//                                     child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: ListTile(
//                                           leading: CircleAvatar(
//                                             backgroundImage: NetworkImage(state
//                                                 .userProfile
//                                                 .user!
//                                                 .profilePicture!
//                                                 .secureUrl!),
//                                           ),
//                                           title: Text(state
//                                               .userProfile.user!.fullName!),
//                                           subtitle: Text(
//                                               state.userProfile.user!.email!),
//                                         )),
//                                   ),
//                                 );
//                               }
//                               return const SizedBox();
//                             },
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           //---------------------------------------------------------payment
//                           const Text(
//                             'Payment details',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text('Consultation Fee '),
//                                     Text(
//                                         '${state.doct.speciality!.fees.toString()} Rs')
//                                   ],
//                                 ),
//                                 const Divider(),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text('Amount to pay '),
//                                     Text(
//                                         '${state.doct.speciality!.fees.toString()} Rs')
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           Center(
//                             child: SizedBox(
//                               height: 40,
//                               width: 100,
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   //--------->>>>>>>>>>>>>>-------------------payment click here --<<<<<<<<<<<<<<<<<<<<
//                                   context
//                                       .read<BookingTrackerBloc>()
//                                       .add(BookingStartPayment());

//                                   await Future.delayed(Duration(seconds: 5));

//                                   var options = {
//                                     'key': razor_key,
//                                     'order_id': state.bookingDetails.orderID,
//                                     'amount': ((state.doct.speciality!.fees)! *
//                                         100), // Amount in paise
//                                     'name': 'DocCure',
//                                     'description':
//                                         'Consultation Fee : ${state.doct.fullName}',
//                                     'prefill': {
//                                       'contact': profilePatientDetails!.phone,
//                                       'email': profilePatientDetails!.email
//                                     },
//                                     'external': {
//                                       'wallets': [
//                                         'paytm'
//                                       ] // List of allowed wallets
//                                     }
//                                   };

//                                   // Open Razorpay checkout

//                                   void _handlePaymentSuccess(
//                                       PaymentSuccessResponse response) {
//                                     //--------------------------------------------------------patmen
//                                     final details = BookingDetails(
//                                         doctorID: state.bookingDetails.doctorID,
//                                         dateID: state.bookingDetails.dateID,
//                                         slotID: state.bookingDetails.slotID,
//                                         startTime:
//                                             state.bookingDetails.startTime,
//                                         endTime: state.bookingDetails.endTime,
//                                         date: state.bookingDetails.date,
//                                         fees: state.bookingDetails.fees,
//                                         orderID: state.bookingDetails.orderID,
//                                         paymentid: response.paymentId);

//                                     if (details.orderID != null &&
//                                         details.paymentid != null) {
//                                       log('did : ${state.bookingDetails.doctorID}, dateid : ${state.bookingDetails.dateID}, slotid : ${state.bookingDetails.slotID} ,  startd : ${state.bookingDetails.startTime}, end ;${state.bookingDetails.endTime},fees : ${state.bookingDetails.fees},orderid : ${state.bookingDetails.orderID}, paymn : ${response.paymentId}');
//                                       //--------------------------------------------------final appointment bloc call
//                                       context.read<BookingTrackerBloc>().add(
//                                           BookingSucessPayment(
//                                               bookingdetails: details,
//                                               patientDetails:
//                                                   profilePatientDetails!,
//                                               doctor: state.doct));
//                                     }
//                                   }

//                                   void _handlePaymentError(
//                                       PaymentFailureResponse response) {
//                                     log('cancelled payment from Razorpay ui');
//                                     Navigator.of(contextScaffold).pop();
//                                     context
//                                         .read<BookingTrackerBloc>()
//                                         .add(BookingTrackClear());
//                                     log(context.widget.toString());
//                                     //-----------------------------------context changed to scaffold
//                                   }

//                                   void _handleExternalWallet(
//                                       ExternalWalletResponse response) {
//                                     log('cancelled wallet');
//                                     log('cancelled payment from Razorpay ui');
//                                     context
//                                         .read<BookingTrackerBloc>()
//                                         .add(BookingTrackClear());
//                                     log(context.widget.toString());
//                                     //-----------------------------------context changed to scaffold
//                                   }

//                                   //-------------------------------------------------------listoners to razorpay
//                                   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
//                                       _handlePaymentSuccess);
//                                   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
//                                       _handlePaymentError);
//                                   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
//                                       _handleExternalWallet);

//                                   _razorpay.open(options);
//                                 },
//                                 child: const Text('Pay'),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               }

//               return const SizedBox();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
