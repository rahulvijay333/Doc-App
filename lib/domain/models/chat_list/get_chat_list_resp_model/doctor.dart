import 'package:json_annotation/json_annotation.dart';

import 'profile_picture.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  ProfilePicture? profilePicture;
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;
  String? fullName;

  Doctor({
    this.profilePicture,
    this.id,
    this.name,
    this.email,
    this.fullName,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return _$DoctorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
