import 'package:json_annotation/json_annotation.dart';

import 'appointment.dart';

part 'get_all_appointment_response.g.dart';

//-------------------------------------------------------doctor side
@JsonSerializable()
class GetAllAppointmentResponse {
  List<Appointment>? appointments;

  GetAllAppointmentResponse({this.appointments});

  factory GetAllAppointmentResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAllAppointmentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllAppointmentResponseToJson(this);
}
