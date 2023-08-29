import 'package:json_annotation/json_annotation.dart';

part 'latest_message.g.dart';

@JsonSerializable()
class LatestMessage {
  @JsonKey(name: '_id')
  String? id;
  String? conversation;
  String? sender;
  String? senderModel;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  LatestMessage({
    this.id,
    this.conversation,
    this.sender,
    this.senderModel,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) {
    return _$LatestMessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LatestMessageToJson(this);
}
