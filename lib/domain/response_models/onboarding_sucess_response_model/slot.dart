import 'package:json_annotation/json_annotation.dart';

part 'slot.g.dart';

@JsonSerializable()
class Slot {
  String? startTime;
  String? endTime;
  bool? status;
  @JsonKey(name: '_id')
  String? id;

  Slot({this.startTime, this.endTime, this.status, this.id});

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);

  Map<String, dynamic> toJson() => _$SlotToJson(this);
}
