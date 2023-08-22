import 'package:json_annotation/json_annotation.dart';

import 'appointment.dart';

part 'view_appointment_patient_side_bloc.g.dart';

@JsonSerializable()
class ViewAppointmentPatientSide {
  List<Appointment>? appointments;

  ViewAppointmentPatientSide({this.appointments});

  factory ViewAppointmentPatientSide.fromJson(Map<String, dynamic> json) {
    return _$ViewAppointmentPatientSideFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ViewAppointmentPatientSideToJson(this);
  }
}
