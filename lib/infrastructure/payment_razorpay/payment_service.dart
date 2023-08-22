import 'dart:developer';

import 'package:appoint_medic/infrastructure/key_razor/razor_pay_key.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  final Razorpay _razorpay = Razorpay();

  Future<void> startPayment() async {
    var options = {
      'key': razor_key,
      'amount': (500 * 100), // Amount in paise
      'name': 'DocCure',
      // 'order_id': bookingDetails.orderID,
      'description': 'Consultation Fee',
      'prefill': {'contact': '12345893', 'email': 'rjust.test1496@gmail.com'},
      'external': {
        'wallets': ['paytm'] // List of allowed wallets
      }
    };

    // Open Razorpay checkout
    _razorpay.open(options);

    // Listen to payment success or failure
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      log('payment order : ${response.paymentId}');
      // onPaymentSuccess();
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (responseError) {
      log('error happned');
      // onPaymentError();
    });

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (responseCancel) {
      log('cancel happned');
      // onPaymentCancel();
    });
  }
}
