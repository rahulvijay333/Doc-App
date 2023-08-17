import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'available_slot.dart';
import 'certificate.dart';
import 'comment.dart';
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
  String? password;
  bool? isVerified;
  bool? isAdminVerified;
  String? role;
  @JsonKey(name: '__v')
  int? v;
  List<AvailableSlot>? availableSlots;
  List<Comment>? comments;
  String? phone;
  String? qualification;
  String? speciality;
  List<String>? services;
  String? fullName;
  String? gender;

  User({
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
    this.phone,
    this.qualification,
    this.speciality,
    this.services,
    this.fullName,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
