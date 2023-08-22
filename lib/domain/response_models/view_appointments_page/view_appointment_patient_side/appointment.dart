import 'package:json_annotation/json_annotation.dart';

import 'doctor.dart';
import 'speciality.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  @JsonKey(name: '_id')
  String? id;
  String? doctorId;
  String? patientId;
  String? fees;
  String? startTime;
  String? endTime;
  String? dateId;
  String? slotId;
  String? paymentId;
  String? orderId;
  bool? isApprovedByDoctor;
  bool? isCancelled;
  bool? isRefund;
  @JsonKey(name: '__v')
  int? v;
  Doctor? doctor;
  Speciality? speciality;
  DateTime? selectedDate;

  Appointment({
    this.id,
    this.doctorId,
    this.patientId,
    this.fees,
    this.startTime,
    this.endTime,
    this.dateId,
    this.slotId,
    this.paymentId,
    this.orderId,
    this.isApprovedByDoctor,
    this.isCancelled,
    this.isRefund,
    this.v,
    this.doctor,
    this.speciality,
    this.selectedDate,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return _$AppointmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
