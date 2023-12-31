// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: json['_id'] as String?,
      doctorId: json['doctorId'] as String?,
      patientId: json['patientId'] as String?,
      fees: json['fees'] as String?,
      startTime: json['startTime'] as String?,
      selectedDate: json['selectedDate'] == null
          ? null
          : DateTime.parse(json['selectedDate'] as String),
      endTime: json['endTime'] as String?,
      dateId: json['dateId'] as String?,
      slotId: json['slotId'] as String?,
      paymentId: json['paymentId'] as String?,
      orderId: json['orderId'] as String?,
      isApprovedByDoctor: json['isApprovedByDoctor'] as bool?,
      isCancelled: json['isCancelled'] as bool?,
      isRefund: json['isRefund'] as bool?,
      v: json['__v'] as int?,
      patient: json['patient'] == null
          ? null
          : Patient.fromJson(json['patient'] as Map<String, dynamic>),
    )..reason = json['reason'] as String?;

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
      'fees': instance.fees,
      'startTime': instance.startTime,
      'selectedDate': instance.selectedDate?.toIso8601String(),
      'endTime': instance.endTime,
      'dateId': instance.dateId,
      'slotId': instance.slotId,
      'paymentId': instance.paymentId,
      'orderId': instance.orderId,
      'reason': instance.reason,
      'isApprovedByDoctor': instance.isApprovedByDoctor,
      'isCancelled': instance.isCancelled,
      'isRefund': instance.isRefund,
      '__v': instance.v,
      'patient': instance.patient,
    };
