import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse {
  bool? success;
  String? message;

  LogoutResponse({this.success, this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return _$LogoutResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);
}
