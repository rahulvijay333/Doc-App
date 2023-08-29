import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'available_slot.dart';
import 'certificate.dart';
import 'comment.dart';
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
  List<AvailableSlot>? availableSlots;
  List<Comment>? comments;
  String? fullName;
  String? gender;
  String? phone;
  String? qualification;
  List<String>? services;
  Speciality? speciality;

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
    this.availableSlots,
    this.comments,
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
