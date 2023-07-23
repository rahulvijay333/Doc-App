// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
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
      password: json['password'] as String?,
      isVerified: json['isVerified'] as bool?,
      isAdminVerified: json['isAdminVerified'] as bool?,
      role: json['role'] as String?,
      v: json['__v'] as int?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      speciality: json['speciality'] == null
          ? null
          : Speciality.fromJson(json['speciality'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      availableSlots: (json['availableSlots'] as List<dynamic>?)
          ?.map((e) => AvailableSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      qualification: json['qualification'] as String?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'profilePicture': instance.profilePicture,
      'certificate': instance.certificate,
      'address': instance.address,
      'likes': instance.likes,
      'ratings': instance.ratings,
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'isVerified': instance.isVerified,
      'isAdminVerified': instance.isAdminVerified,
      'role': instance.role,
      '__v': instance.v,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'phone': instance.phone,
      'speciality': instance.speciality,
      'services': instance.services,
      'availableSlots': instance.availableSlots,
      'qualification': instance.qualification,
    };
