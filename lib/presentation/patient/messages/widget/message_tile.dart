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

    return Container(
      color: Colors.white.withOpacity(0.4),
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            // You can customize the avatar image here
            backgroundImage: NetworkImage(Image),
            //backgroundColor: Colors.blue, // Customize the avatar's background color
          ),
          SizedBox(
              width:
                  8), // Adjust the spacing between the avatar and the message content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  senderName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                    height:
                        4), // Adjust the spacing between the sender name and message
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              width:
                  8), // Adjust the spacing between the message content and the time
          Container(
            child: Center(
              child: Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                //textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
