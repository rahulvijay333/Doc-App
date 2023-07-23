import 'package:json_annotation/json_annotation.dart';

import 'slot.dart';

part 'available_slot.g.dart';

@JsonSerializable()
class AvailableSlot {
  DateTime? date;
  List<Slot>? slots;
  @JsonKey(name: '_id')
  String? id;

  AvailableSlot({this.date, this.slots, this.id});

  factory AvailableSlot.fromJson(Map<String, dynamic> json) {
    return _$AvailableSlotFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AvailableSlotToJson(this);
}
