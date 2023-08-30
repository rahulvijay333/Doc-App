import 'package:json_annotation/json_annotation.dart';

import 'conversation.dart';
import 'sender.dart';

part 'new_chat_response.g.dart';

@JsonSerializable()
class NewChatResponse {
  @JsonKey(name: '_id')
  String? id;
  Conversation? conversation;
  Sender? sender;
  String? senderModel;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  NewChatResponse({
    this.id,
    this.conversation,
    this.sender,
    this.senderModel,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NewChatResponse.fromJson(Map<String, dynamic> json) {
    return _$NewChatResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewChatResponseToJson(this);
}
