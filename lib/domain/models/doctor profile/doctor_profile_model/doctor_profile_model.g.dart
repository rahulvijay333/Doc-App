// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorProfileModel _$DoctorProfileModelFromJson(Map<String, dynamic> json) =>
    DoctorProfileModel(
      doctor: json['doctor'] == null
          ? null
          : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DoctorProfileModelToJson(DoctorProfileModel instance) =>
    <String, dynamic>{
      'doctor': instance.doctor,
    };
