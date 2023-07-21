import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'certificate.dart';
import 'likes.dart';
import 'profile_picture.dart';
import 'ratings.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  ProfilePicture? profilePicture;
  Certificate? certificate;
  Address? address;
  Likes? likes;
  Ratings? ratings;
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;
  List<String>? services;
  bool? isVerified;
  bool? isAdminVerified;
  String? role;
  List<dynamic>? comments;
  List<dynamic>? availableSlots;
  @JsonKey(name: '__v')
  int? v;
  String? fullName;
  String? gender;
  String? phone;
  String? qualification;
  String? speciality;
  String? token;

  User({
    this.profilePicture,
    this.certificate,
    this.address,
    this.likes,
    this.ratings,
    this.id,
    this.name,
    this.email,
    this.services,
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
    this.speciality,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
