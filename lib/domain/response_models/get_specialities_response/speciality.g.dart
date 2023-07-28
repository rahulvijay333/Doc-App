// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speciality _$SpecialityFromJson(Map<String, dynamic> json) => Speciality(
      specialityImg: json['specialityImg'] == null
          ? null
          : SpecialityImg.fromJson(
              json['specialityImg'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      fees: json['fees'] as String?,
      isAdminVerified: json['isAdminVerified'] as bool?,
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$SpecialityToJson(Speciality instance) =>
    <String, dynamic>{
      'specialityImg': instance.specialityImg,
      '_id': instance.id,
      'name': instance.name,
      'fees': instance.fees,
      'isAdminVerified': instance.isAdminVerified,
      '__v': instance.v,
    };
