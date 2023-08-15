// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ratings _$RatingsFromJson(Map<String, dynamic> json) => Ratings(
      number: json['number'] as int?,
      user: (json['user'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RatingsToJson(Ratings instance) => <String, dynamic>{
      'number': instance.number,
      'user': instance.user,
    };
