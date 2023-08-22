// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_booked_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentBookedResponse _$AppointmentBookedResponseFromJson(
        Map<String, dynamic> json) =>
    AppointmentBookedResponse(
      appointment: json['appointment'] == null
          ? null
          : Appointment.fromJson(json['appointment'] as Map<String, dynamic>),
      newNotification: json['newNotification'] == null
          ? null
          : NewNotification.fromJson(
              json['newNotification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentBookedResponseToJson(
        AppointmentBookedResponse instance) =>
    <String, dynamic>{
      'appointment': instance.appointment,
      'newNotification': instance.newNotification,
    };
