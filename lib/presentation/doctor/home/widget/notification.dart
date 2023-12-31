import 'package:flutter/material.dart';

class NotificationBell extends StatelessWidget {
  final int notificationCount;

  NotificationBell({required this.notificationCount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Icon(
          Icons.notifications,
          size: size.width * 0.07,
          color: Colors.white, // Adjust color as needed
        ),
        if (notificationCount > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red, // Badge color
                shape: BoxShape.circle,
              ),
              child: Text(
                notificationCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
