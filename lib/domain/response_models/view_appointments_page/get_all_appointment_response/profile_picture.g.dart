// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePicture _$ProfilePictureFromJson(Map<String, dynamic> json) =>
    ProfilePicture(
      publicId: json['public_id'] as String?,
      secureUrl: json['secure_url'] as String?,
    );

Map<String, dynamic> _$ProfilePictureToJson(ProfilePicture instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'secure_url': instance.secureUrl,
    };
