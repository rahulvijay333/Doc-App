import 'package:json_annotation/json_annotation.dart';

import 'doctor.dart';

part 'doctors_response_model.g.dart';

@JsonSerializable()
class DoctorsResponseModel {
  bool? success;
  List<Doctor>? doctors;

  DoctorsResponseModel({this.success, this.doctors});

  factory DoctorsResponseModel.fromJson(Map<String, dynamic> json) {
    return _$DoctorsResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorsResponseModelToJson(this);
}
