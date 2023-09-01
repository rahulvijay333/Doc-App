// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      email: json['email'] as String?,
      otp: json['otp'] as int?,
      otpExpiry: json['otpExpiry'] == null
          ? null
          : DateTime.parse(json['otpExpiry'] as String),
      services: json['services'] as List<dynamic>?,
      isVerified: json['isVerified'] as bool?,
      isAdminVerified: json['isAdminVerified'] as bool?,
      role: json['role'] as String?,
      likes: json['likes'] == null
          ? null
          : Likes.fromJson(json['likes'] as Map<String, dynamic>),
      ratings: json['ratings'] == null
          ? null
          : Ratings.fromJson(json['ratings'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      comments: json['comments'] as List<dynamic>?,
      availableSlots: json['availableSlots'] as List<dynamic>?,
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'otp': instance.otp,
      'otpExpiry': instance.otpExpiry?.toIso8601String(),
      'services': instance.services,
      'isVerified': instance.isVerified,
      'isAdminVerified': instance.isAdminVerified,
      'role': instance.role,
      'likes': instance.likes,
      'ratings': instance.ratings,
      '_id': instance.id,
      'comments': instance.comments,
      'availableSlots': instance.availableSlots,
      '__v': instance.v,
    };
