import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'onboarding_sucess_response_model.g.dart';

@JsonSerializable()
class OnboardingSucessResponseModel {
  String? message;
  User? user;

  OnboardingSucessResponseModel({this.message, this.user});

  factory OnboardingSucessResponseModel.fromJson(Map<String, dynamic> json) {
    return _$OnboardingSucessResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OnboardingSucessResponseModelToJson(this);
}
