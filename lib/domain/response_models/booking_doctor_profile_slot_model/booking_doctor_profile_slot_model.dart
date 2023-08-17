import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'booking_doctor_profile_slot_model.g.dart';

@JsonSerializable()
class BookingDoctorProfileSlotModel {
  String? message;
  User? user;

  BookingDoctorProfileSlotModel({this.message, this.user});

  factory BookingDoctorProfileSlotModel.fromJson(Map<String, dynamic> json) {
    return _$BookingDoctorProfileSlotModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookingDoctorProfileSlotModelToJson(this);
}
