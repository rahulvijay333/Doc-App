import 'package:json_annotation/json_annotation.dart';

import 'sender.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  @JsonKey(name: '_id')
  String? id;
  String? recipient;
  String? recipientType;
  Sender? sender;
  String? senderType;
  String? message;
  bool? read;
  DateTime? createdAt;
  @JsonKey(name: '__v')
  int? v;

  Notification({
    this.id,
    this.recipient,
    this.recipientType,
    this.sender,
    this.senderType,
    this.message,
    this.read,
    this.createdAt,
    this.v,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return _$NotificationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
