import 'package:appoint_medic/domain/response_models/profile_model/profile_model.dart';
import 'package:flutter/material.dart';

class ScreenPersonalDetails extends StatelessWidget {
  const ScreenPersonalDetails({super.key, required this.user});
  final ProfileModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: 150,
            height: 150,
            color: Colors.red,
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(user.user!.profilePicture!.secureUrl!),
            ),
          ),
          Text('Name : ${user.user!.name}'),
          Text('Age : ${user.user!.gender} '),
          Text('Email :  ${user.user!.email}'),
          Text('Address'),
          Text(user.user!.address!.toString())
        ],
      ),
    );
  }
}
