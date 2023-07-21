// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUserResponse _$NewUserResponseFromJson(Map<String, dynamic> json) =>
    NewUserResponse(
      success: json['success'] as bool?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewUserResponseToJson(NewUserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'user': instance.user,
    };
