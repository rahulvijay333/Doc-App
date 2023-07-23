import 'package:flutter/material.dart';

class IconTextNumberDisplay extends StatelessWidget {
  const IconTextNumberDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar();
  }
}

class CircleAvatarWithWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 75.0,
      decoration: BoxDecoration(
        //  color: Colors.amber,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bed,
            size: 20.0,
            color: Colors.white,
          ),
          SizedBox(height: 10.0),
          Text(
            '1500',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
