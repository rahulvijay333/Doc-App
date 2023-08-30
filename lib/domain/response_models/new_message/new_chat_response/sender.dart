import 'package:json_annotation/json_annotation.dart';

import 'profile_picture.dart';

part 'sender.g.dart';

@JsonSerializable()
class Sender {
  ProfilePicture? profilePicture;
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? email;

  Sender({this.profilePicture, this.id, this.name, this.email});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return _$SenderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SenderToJson(this);
}
