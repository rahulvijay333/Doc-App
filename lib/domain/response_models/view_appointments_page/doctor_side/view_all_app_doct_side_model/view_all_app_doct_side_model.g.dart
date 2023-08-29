// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_all_app_doct_side_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewAllAppDoctSideModel _$ViewAllAppDoctSideModelFromJson(
        Map<String, dynamic> json) =>
    ViewAllAppDoctSideModel(
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ViewAllAppDoctSideModelToJson(
        ViewAllAppDoctSideModel instance) =>
    <String, dynamic>{
      'appointments': instance.appointments,
    };
