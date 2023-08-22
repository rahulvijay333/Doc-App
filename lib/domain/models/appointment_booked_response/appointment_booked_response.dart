import 'package:json_annotation/json_annotation.dart';

import 'appointment.dart';
import 'new_notification.dart';

part 'appointment_booked_response.g.dart';

@JsonSerializable()
class AppointmentBookedResponse {
  Appointment? appointment;
  NewNotification? newNotification;

  AppointmentBookedResponse({this.appointment, this.newNotification});

  factory AppointmentBookedResponse.fromJson(Map<String, dynamic> json) {
    return _$AppointmentBookedResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppointmentBookedResponseToJson(this);
}
