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
      availableSlots: (json['availableSlots'] as List<dynamic>?)
          ?.map((e) => AvailableSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'profilePicture': instance.profilePicture,
      'certificate': instance.certificate,
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
      'availableSlots': instance.availableSlots,
      'comments': instance.comments,
      'fullName': instance.fullName,
    };
