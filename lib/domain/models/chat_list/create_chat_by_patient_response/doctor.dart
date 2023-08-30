import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'available_slot.dart';
import 'certificate.dart';
import 'likes.dart';
import 'profile_picture.dart';
import 'ratings.dart';

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
  int? otp;
  DateTime? otpExpiry;
  bool? isVerified;
  bool? isAdminVerified;
  String? role;
  List<dynamic>? comments;
  List<AvailableSlot>? availableSlots;
  @JsonKey(name: '__v')
  int? v;
  String? fullName;
  String? gender;
  String? phone;
  String? qualification;
  List<String>? services;
  String? speciality;

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
    this.otp,
    this.otpExpiry,
    this.isVerified,
    this.isAdminVerified,
    this.role,
    this.comments,
    this.availableSlots,
    this.v,
    this.fullName,
    this.gender,
    this.phone,
    this.qualification,
    this.services,
    this.speciality,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return _$DoctorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
