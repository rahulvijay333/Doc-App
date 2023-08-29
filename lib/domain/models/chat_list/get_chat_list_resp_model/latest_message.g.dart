// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestMessage _$LatestMessageFromJson(Map<String, dynamic> json) =>
    LatestMessage(
      id: json['_id'] as String?,
      conversation: json['conversation'] as String?,
      sender: json['sender'] as String?,
      senderModel: json['senderModel'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$LatestMessageToJson(LatestMessage instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'conversation': instance.conversation,
      'sender': instance.sender,
      'senderModel': instance.senderModel,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
