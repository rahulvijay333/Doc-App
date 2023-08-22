// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_appointment_patient_side_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewAppointmentPatientSide _$ViewAppointmentPatientSideFromJson(
        Map<String, dynamic> json) =>
    ViewAppointmentPatientSide(
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ViewAppointmentPatientSideToJson(
        ViewAppointmentPatientSide instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
    };
