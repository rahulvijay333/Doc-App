import 'package:json_annotation/json_annotation.dart';

import 'profile_picture.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  ProfilePicture? profilePicture;
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;
  String? fullName;

  Patient({
    this.profilePicture,
    this.id,
    this.name,
    this.email,
    this.fullName,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return _$PatientFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
