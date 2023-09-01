import 'package:json_annotation/json_annotation.dart';

import 'likes.dart';
import 'ratings.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? name;
  String? email;
  int? otp;
  DateTime? otpExpiry;
  List<dynamic>? services;
  bool? isVerified;
  bool? isAdminVerified;
  String? role;
  Likes? likes;
  Ratings? ratings;
  @JsonKey(name: '_id')
  String? id;
  List<dynamic>? comments;
  List<dynamic>? availableSlots;
  @JsonKey(name: '__v')
  int? v;

  User({
    this.name,
    this.email,
    this.otp,
    this.otpExpiry,
    this.services,
    this.isVerified,
    this.isAdminVerified,
    this.role,
    this.likes,
    this.ratings,
    this.id,
    this.comments,
    this.availableSlots,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
