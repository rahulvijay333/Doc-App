// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      profilePicture: json['profilePicture'] == null
          ? null
          : ProfilePicture.fromJson(
              json['profilePicture'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      isVerified: json['isVerified'] as bool?,
      role: json['role'] as String?,
      v: json['__v'] as int?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      isAdminVerified: json['isAdminVerified'] as bool?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'profilePicture': instance.profilePicture,
      'address': instance.address,
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'isVerified': instance.isVerified,
      'role': instance.role,
      '__v': instance.v,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'phone': instance.phone,
      'isAdminVerified': instance.isAdminVerified,
      'token': instance.token,
    };
