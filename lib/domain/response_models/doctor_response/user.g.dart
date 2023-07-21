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
      certificate: json['certificate'] == null
          ? null
          : Certificate.fromJson(json['certificate'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      likes: json['likes'] == null
          ? null
          : Likes.fromJson(json['likes'] as Map<String, dynamic>),
      ratings: json['ratings'] == null
          ? null
          : Ratings.fromJson(json['ratings'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isVerified: json['isVerified'] as bool?,
      isAdminVerified: json['isAdminVerified'] as bool?,
      role: json['role'] as String?,
      comments: json['comments'] as List<dynamic>?,
      availableSlots: json['availableSlots'] as List<dynamic>?,
      v: json['__v'] as int?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      qualification: json['qualification'] as String?,
      speciality: json['speciality'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'profilePicture': instance.profilePicture,
      'certificate': instance.certificate,
      'address': instance.address,
      'likes': instance.likes,
      'ratings': instance.ratings,
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'services': instance.services,
      'isVerified': instance.isVerified,
      'isAdminVerified': instance.isAdminVerified,
      'role': instance.role,
      'comments': instance.comments,
      'availableSlots': instance.availableSlots,
      '__v': instance.v,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'phone': instance.phone,
      'qualification': instance.qualification,
      'speciality': instance.speciality,
      'token': instance.token,
    };
