import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'profile_picture.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;
  bool? isVerified;
  String? role;
  @JsonKey(name: '__v')
  int? v;
  Address? address;
  String? fullName;
  String? gender;
  String? phone;
  ProfilePicture? profilePicture;
  bool? isAdminVerified;

  Patient({
    this.id,
    this.name,
    this.email,
    this.isVerified,
    this.role,
    this.v,
    this.address,
    this.fullName,
    this.gender,
    this.phone,
    this.profilePicture,
    this.isAdminVerified,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return _$PatientFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
