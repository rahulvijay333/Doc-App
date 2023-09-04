// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      id: json['_id'] as String?,
      recipient: json['recipient'] as String?,
      recipientType: json['recipientType'] as String?,
      sender: json['sender'] == null
          ? null
          : Sender.fromJson(json['sender'] as Map<String, dynamic>),
      senderType: json['senderType'] as String?,
      message: json['message'] as String?,
      read: json['read'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'recipient': instance.recipient,
      'recipientType': instance.recipientType,
      'sender': instance.sender,
      'senderType': instance.senderType,
      'message': instance.message,
      'read': instance.read,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.v,
    };
