import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'new_user_response.g.dart';

@JsonSerializable()
class NewUserResponse {
  bool? success;
  User? user;

  NewUserResponse({this.success, this.user});

  factory NewUserResponse.fromJson(Map<String, dynamic> json) {
    return _$NewUserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewUserResponseToJson(this);
}
