// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      profilePicture: json['profilePicture'] == null
          ? null
          : ProfilePicture.fromJson(
              json['profilePicture'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'profilePicture': instance.profilePicture,
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'fullName': instance.fullName,
    };
