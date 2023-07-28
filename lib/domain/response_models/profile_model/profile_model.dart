import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  String? message;
  User? user;

  ProfileModel({this.message, this.user});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return _$ProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
