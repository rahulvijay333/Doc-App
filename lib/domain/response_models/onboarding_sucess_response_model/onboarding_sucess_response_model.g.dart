// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_sucess_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingSucessResponseModel _$OnboardingSucessResponseModelFromJson(
        Map<String, dynamic> json) =>
    OnboardingSucessResponseModel(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OnboardingSucessResponseModelToJson(
        OnboardingSucessResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };
