import 'package:flutter/material.dart';

Future<void> showPopupAndWait(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text('Clearing Payment Details'),
        content: Text('Please wait...'),
      );
    },
  );

  // Wait for 10 seconds
  await Future.delayed(const Duration(seconds: 10));

  // Close the popup
  Navigator.of(context).pop();
}
