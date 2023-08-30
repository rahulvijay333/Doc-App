// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewChatResponse _$NewChatResponseFromJson(Map<String, dynamic> json) =>
    NewChatResponse(
      id: json['_id'] as String?,
      conversation: json['conversation'] == null
          ? null
          : Conversation.fromJson(json['conversation'] as Map<String, dynamic>),
      sender: json['sender'] == null
          ? null
          : Sender.fromJson(json['sender'] as Map<String, dynamic>),
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

Map<String, dynamic> _$NewChatResponseToJson(NewChatResponse instance) =>
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
