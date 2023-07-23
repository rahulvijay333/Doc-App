// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Likes _$LikesFromJson(Map<String, dynamic> json) => Likes(
      number: json['number'] as int?,
      user: (json['user'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LikesToJson(Likes instance) => <String, dynamic>{
      'number': instance.number,
      'user': instance.user,
    };
