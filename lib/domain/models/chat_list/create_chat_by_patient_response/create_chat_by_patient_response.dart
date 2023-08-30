import 'package:json_annotation/json_annotation.dart';

import 'participant.dart';

part 'create_chat_by_patient_response.g.dart';

@JsonSerializable()
class CreateChatByPatientResponse {
  List<Participant>? participants;
  @JsonKey(name: '_id')
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  CreateChatByPatientResponse({
    this.participants,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CreateChatByPatientResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateChatByPatientResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateChatByPatientResponseToJson(this);
}
