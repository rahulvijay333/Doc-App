// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_specialities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSpecialitiesResponse _$GetSpecialitiesResponseFromJson(
        Map<String, dynamic> json) =>
    GetSpecialitiesResponse(
      success: json['success'] as bool?,
      specialities: (json['specialities'] as List<dynamic>?)
          ?.map((e) => Speciality.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSpecialitiesResponseToJson(
        GetSpecialitiesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'specialities': instance.specialities,
    };
