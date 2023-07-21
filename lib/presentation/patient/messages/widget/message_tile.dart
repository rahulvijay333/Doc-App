import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String senderName;
  final String message;
  final String time;

  MessageTile({
    required this.senderName,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            // You can customize the avatar image here
           backgroundImage: AssetImage('assets/doctor.png'),
            //backgroundColor: Colors.blue, // Customize the avatar's background color
          ),
          SizedBox(width: 8), // Adjust the spacing between the avatar and the message content
          Expanded(
            child: Column(
             mainAxisAlignment:MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Text(
                  senderName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 4), // Adjust the spacing between the sender name and message
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8), // Adjust the spacing between the message content and the time
          Container(
            child: Center(
              child: Text(
                time,
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
