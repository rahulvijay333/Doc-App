import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'certificate.dart';
import 'comment.dart';
import 'likes.dart';
import 'profile_picture.dart';
import 'ratings.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;
  bool? isVerified;
  bool? isAdminVerified;
  String? role;
  @JsonKey(name: '__v')
  int? v;
  Address? address;
  Certificate? certificate;
  ProfilePicture? profilePicture;
  Likes? likes;
  Ratings? ratings;
  List<Comment>? comments;
  String? fullName;
  String? gender;
  String? phone;
  String? qualification;
  String? speciality;

  Doctor({
    this.id,
    this.name,
    this.email,
    this.isVerified,
    this.isAdminVerified,
    this.role,
    this.v,
    this.address,
    this.certificate,
    this.profilePicture,
    this.likes,
    this.ratings,
    this.comments,
    this.fullName,
    this.gender,
    this.phone,
    this.qualification,
    this.speciality,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return _$DoctorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
