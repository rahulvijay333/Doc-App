import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'profile_picture.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  ProfilePicture? profilePicture;
  Address? address;
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;
  bool? isVerified;
  String? role;
  @JsonKey(name: '__v')
  int? v;
  String? fullName;
  String? gender;
  String? phone;
  bool? isAdminVerified;
  String? token;

  User({
    this.profilePicture,
    this.address,
    this.id,
    this.name,
    this.email,
    this.isVerified,
    this.role,
    this.v,
    this.fullName,
    this.gender,
    this.phone,
    this.isAdminVerified,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
