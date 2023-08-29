import 'package:json_annotation/json_annotation.dart';

import 'latest_message.dart';
import 'participant.dart';

part 'get_chat_list_resp_model.g.dart';

@JsonSerializable()
class GetChatListRespModel {
  @JsonKey(name: '_id')
  String? id;
  List<Participant>? participants;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  LatestMessage? latestMessage;

  GetChatListRespModel({
    this.id,
    this.participants,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestMessage,
  });

  static List<GetChatListRespModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GetChatListRespModel.fromJson(json)).toList();
  }

  factory GetChatListRespModel.fromJson(Map<String, dynamic> json) {
    return _$GetChatListRespModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetChatListRespModelToJson(this);
}
