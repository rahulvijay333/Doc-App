import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  final String senderName;
  final String message;
  final DateTime time;
  final String Image;

  MessageTile({
    required this.senderName,
    required this.message,
    required this.time,
    required this.Image,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(time.toString());

    String formattedTime = DateFormat('h:mm a').format(dateTime.toLocal());

    return Card(
      elevation: 1,
      child: Container(
        color: Colors.white.withOpacity(0.1),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 25,
                // You can customize the avatar image here
                backgroundImage: NetworkImage(Image),
                //backgroundColor: Colors.blue, // Customize the avatar's background color
              ),
            ),
            const SizedBox(
                width:
                    8), // Adjust the spacing between the avatar and the message content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   "$senderName",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                      height:
                          4), // Adjust the spacing between the sender name and message
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
                width:
                    8), 
            Container(
              child: Center(
                child: Text(
                  formattedTime,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  //textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
