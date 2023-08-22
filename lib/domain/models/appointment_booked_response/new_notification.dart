import 'package:json_annotation/json_annotation.dart';

part 'new_notification.g.dart';

@JsonSerializable()
class NewNotification {
  String? recipient;
  String? recipientType;
  String? sender;
  String? senderType;
  String? message;
  bool? read;
  @JsonKey(name: '_id')
  String? id;
  DateTime? createdAt;
  @JsonKey(name: '__v')
  int? v;

  NewNotification({
    this.recipient,
    this.recipientType,
    this.sender,
    this.senderType,
    this.message,
    this.read,
    this.id,
    this.createdAt,
    this.v,
  });

  factory NewNotification.fromJson(Map<String, dynamic> json) {
    return _$NewNotificationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewNotificationToJson(this);
}
