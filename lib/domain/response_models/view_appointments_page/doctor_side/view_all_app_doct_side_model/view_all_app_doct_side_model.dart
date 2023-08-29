import 'package:json_annotation/json_annotation.dart';

import 'appointment.dart';

part 'view_all_app_doct_side_model.g.dart';

@JsonSerializable()
class ViewAllAppDoctSideModel {
  List<Appointment>? appointments;

  ViewAllAppDoctSideModel({this.appointments});

  factory ViewAllAppDoctSideModel.fromJson(Map<String, dynamic> json) {
    return _$ViewAllAppDoctSideModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ViewAllAppDoctSideModelToJson(this);
}
