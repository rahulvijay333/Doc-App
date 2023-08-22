// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      isVerified: json['isVerified'] as bool?,
      role: json['role'] as String?,
      v: json['__v'] as int?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      profilePicture: json['profilePicture'] == null
          ? null
          : ProfilePicture.fromJson(
              json['profilePicture'] as Map<String, dynamic>),
      isAdminVerified: json['isAdminVerified'] as bool?,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'isVerified': instance.isVerified,
      'role': instance.role,
      '__v': instance.v,
      'address': instance.address,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'phone': instance.phone,
      'profilePicture': instance.profilePicture,
      'isAdminVerified': instance.isAdminVerified,
    };
