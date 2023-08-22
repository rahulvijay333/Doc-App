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
      endTime: json['endTime'] as String?,
      dateId: json['dateId'] as String?,
      slotId: json['slotId'] as String?,
      paymentId: json['paymentId'] as String?,
      orderId: json['orderId'] as String?,
      isApprovedByDoctor: json['isApprovedByDoctor'] as bool?,
      isCancelled: json['isCancelled'] as bool?,
      isRefund: json['isRefund'] as bool?,
      v: json['__v'] as int?,
      doctor: json['doctor'] == null
          ? null
          : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
      speciality: json['speciality'] == null
          ? null
          : Speciality.fromJson(json['speciality'] as Map<String, dynamic>),
      selectedDate: json['selectedDate'] == null
          ? null
          : DateTime.parse(json['selectedDate'] as String),
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      '_id': instance.id,
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
      '__v': instance.v,
      'doctor': instance.doctor,
      'speciality': instance.speciality,
      'selectedDate': instance.selectedDate?.toIso8601String(),
    };
