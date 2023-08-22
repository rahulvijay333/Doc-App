// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAppointmentResponse _$GetAllAppointmentResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllAppointmentResponse(
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllAppointmentResponseToJson(
        GetAllAppointmentResponse instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
    };
