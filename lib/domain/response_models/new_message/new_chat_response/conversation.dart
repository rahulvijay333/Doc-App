import 'package:json_annotation/json_annotation.dart';

import 'participant.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  @JsonKey(name: '_id')
  String? id;
  List<Participant>? participants;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  String? latestMessage;

  Conversation({
    this.id,
    this.participants,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestMessage,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return _$ConversationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
