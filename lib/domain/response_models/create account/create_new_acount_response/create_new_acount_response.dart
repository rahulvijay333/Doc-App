import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'create_new_acount_response.g.dart';

@JsonSerializable()
class CreateNewAcountResponse {
  User? user;

  CreateNewAcountResponse({this.user});

  factory CreateNewAcountResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateNewAcountResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateNewAcountResponseToJson(this);
}
