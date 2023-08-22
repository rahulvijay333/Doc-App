// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      doctorId: json['doctorId'] as String?,
      patientId: json['patientId'] as String?,
      fees: json['fees'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      dateId: json['dateId'] as String?,
      slotId: json['slotId'] as String?,
      paymentId: json['paymentId'] as String?,
      orderId: json['orderId'] as String?,
      isApprovedByDoctor: json['isApprovedByDoctor'] as bool?,
      isCancelled: json['isCancelled'] as bool?,
      isRefund: json['isRefund'] as bool?,
      id: json['_id'] as String?,
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
      'fees': instance.fees,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'dateId': instance.dateId,
      'slotId': instance.slotId,
      'paymentId': instance.paymentId,
      'orderId': instance.orderId,
      'isApprovedByDoctor': instance.isApprovedByDoctor,
      'isCancelled': instance.isCancelled,
      'isRefund': instance.isRefund,
      '_id': instance.id,
      '__v': instance.v,
    };
