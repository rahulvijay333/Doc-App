// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      isVerified: json['isVerified'] as bool?,
      isAdminVerified: json['isAdminVerified'] as bool?,
      role: json['role'] as String?,
      v: json['__v'] as int?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      certificate: json['certificate'] == null
          ? null
          : Certificate.fromJson(json['certificate'] as Map<String, dynamic>),
      profilePicture: json['profilePicture'] == null
          ? null
          : ProfilePicture.fromJson(
              json['profilePicture'] as Map<String, dynamic>),
      likes: json['likes'] == null
          ? null
          : Likes.fromJson(json['likes'] as Map<String, dynamic>),
      ratings: json['ratings'] == null
          ? null
          : Ratings.fromJson(json['ratings'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      qualification: json['qualification'] as String?,
      speciality: json['speciality'] as String?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'isVerified': instance.isVerified,
      'isAdminVerified': instance.isAdminVerified,
      'role': instance.role,
      '__v': instance.v,
      'address': instance.address,
      'certificate': instance.certificate,
      'profilePicture': instance.profilePicture,
      'likes': instance.likes,
      'ratings': instance.ratings,
      'comments': instance.comments,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'phone': instance.phone,
      'qualification': instance.qualification,
      'speciality': instance.speciality,
    };
