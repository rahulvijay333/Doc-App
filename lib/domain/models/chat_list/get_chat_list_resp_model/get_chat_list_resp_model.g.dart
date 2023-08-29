// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_chat_list_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetChatListRespModel _$GetChatListRespModelFromJson(
        Map<String, dynamic> json) =>
    GetChatListRespModel(
      id: json['_id'] as String?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
      latestMessage: json['latestMessage'] == null
          ? null
          : LatestMessage.fromJson(
              json['latestMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetChatListRespModelToJson(
        GetChatListRespModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'participants': instance.participants,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'latestMessage': instance.latestMessage,
    };
