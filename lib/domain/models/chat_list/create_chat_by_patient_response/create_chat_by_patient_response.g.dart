// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chat_by_patient_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateChatByPatientResponse _$CreateChatByPatientResponseFromJson(
        Map<String, dynamic> json) =>
    CreateChatByPatientResponse(
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$CreateChatByPatientResponseToJson(
        CreateChatByPatientResponse instance) =>
    <String, dynamic>{
      'participants': instance.participants,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
