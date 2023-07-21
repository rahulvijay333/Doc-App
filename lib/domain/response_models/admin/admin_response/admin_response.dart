import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'admin_response.g.dart';

@JsonSerializable()
class AdminResponse {
  bool? success;
  User? user;

  AdminResponse({this.success, this.user});

  factory AdminResponse.fromJson(Map<String, dynamic> json) {
    return _$AdminResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdminResponseToJson(this);
}
