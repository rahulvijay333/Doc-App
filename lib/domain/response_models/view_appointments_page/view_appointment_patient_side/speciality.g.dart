// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speciality _$SpecialityFromJson(Map<String, dynamic> json) => Speciality(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      fees: json['fees'] as String?,
      specialityImg: json['specialityImg'] == null
          ? null
          : SpecialityImg.fromJson(
              json['specialityImg'] as Map<String, dynamic>),
      isAdminVerified: json['isAdminVerified'] as bool?,
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$SpecialityToJson(Speciality instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'fees': instance.fees,
      'specialityImg': instance.specialityImg,
      'isAdminVerified': instance.isAdminVerified,
      '__v': instance.v,
    };
