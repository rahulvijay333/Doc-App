import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  final String senderName;
  final String message;
  final DateTime time;
  final String imagee;

  const MessageTile({super.key, 
    required this.senderName,
    required this.message,
    required this.time,
    required this.imagee,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(time.toString());

    String formattedTime = DateFormat('h:mm a').format(dateTime.toLocal());

    return Container(
      color: Colors.white.withOpacity(0.8),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                child: imagee.isNotEmpty
                    ? Image.network(
                        imagee,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/person_placeholder.png',
                        fit: BoxFit.cover,
                      ),
                width: 50,
                height: 50,
              ),
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
                  maxLines: 1,
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
          const SizedBox(width: 8),
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
    );
  }
}
