// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_acount_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewAcountResponse _$CreateNewAcountResponseFromJson(
        Map<String, dynamic> json) =>
    CreateNewAcountResponse(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateNewAcountResponseToJson(
        CreateNewAcountResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
