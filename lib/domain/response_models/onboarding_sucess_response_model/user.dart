import 'package:json_annotation/json_annotation.dart';

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

  User({
    this.profilePicture,
    this.certificate,
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
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
