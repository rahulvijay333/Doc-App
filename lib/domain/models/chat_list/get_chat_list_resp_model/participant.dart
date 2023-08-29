import 'package:json_annotation/json_annotation.dart';

import 'doctor.dart';
import 'patient.dart';

part 'participant.g.dart';

@JsonSerializable()
class Participant {
  Doctor? doctor;
  Patient? patient;
  @JsonKey(name: '_id')
  String? id;

  Participant({this.doctor, this.patient, this.id});

  factory Participant.fromJson(Map<String, dynamic> json) {
    return _$ParticipantFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
