import 'package:flutter/material.dart';

class AppbarCustomSize extends StatelessWidget {
  const AppbarCustomSize({
    super.key,
    required this.size,
    required this.title,
  });

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.07,
      color: Colors.blue,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                //-------------------------------------------pop function
                ScaffoldMessenger.of(context).clearSnackBars();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          Expanded(
              child: Text(
            title,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
