import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'available_slot.dart';
import 'certificate.dart';
import 'likes.dart';
import 'profile_picture.dart';
import 'ratings.dart';
import 'speciality.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  ProfilePicture? profilePicture;
  Certificate? certificate;
  Address? address;
  Likes? likes;
  Ratings? ratings;
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;
  String? password;
  bool? isVerified;
  bool? isAdminVerified;
  String? role;
  @JsonKey(name: '__v')
  int? v;
  String? fullName;
  String? gender;
  String? phone;
  Speciality? speciality;
  List<String>? services;
  List<AvailableSlot>? availableSlots;
 
  String? qualification;

  Doctor({
    this.profilePicture,
    this.certificate,
    this.address,
    this.likes,
    this.ratings,
    this.id,
    this.name,
    this.email,
    this.password,
    this.isVerified,
    this.isAdminVerified,
    this.role,
    this.v,
    this.fullName,
    this.gender,
    this.phone,
    this.speciality,
    this.services,
    this.availableSlots,
   
    this.qualification,
  });

  // factory Doctor.fromJson(Map<String, dynamic> json) {
  //   return _$DoctorFromJson(json);
  // }

  factory Doctor.fromJson(Map<String, dynamic> json) {
  try {
    return _$DoctorFromJson(json);
  } catch (e, stackTrace) {
    // Log the error and stack trace for debugging purposes.
    print('Error parsing Doctor: $e\n$stackTrace');
    // Return a default Doctor object or handle the error accordingly.
    return Doctor(); // Or return null, throw an exception, etc.
  }
}

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
