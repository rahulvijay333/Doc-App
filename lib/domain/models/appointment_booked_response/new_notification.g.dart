// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewNotification _$NewNotificationFromJson(Map<String, dynamic> json) =>
    NewNotification(
      recipient: json['recipient'] as String?,
      recipientType: json['recipientType'] as String?,
      sender: json['sender'] as String?,
      senderType: json['senderType'] as String?,
      message: json['message'] as String?,
      read: json['read'] as bool?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$NewNotificationToJson(NewNotification instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'recipientType': instance.recipientType,
      'sender': instance.sender,
      'senderType': instance.senderType,
      'message': instance.message,
      'read': instance.read,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
    };
