import 'package:json_annotation/json_annotation.dart';

import 'slot.dart';

part 'filtered_slot.g.dart';

@JsonSerializable()
class FilteredSlot {
  DateTime? date;
  List<Slot>? slots;
  @JsonKey(name: '_id')
  String? id;

  FilteredSlot({this.date, this.slots, this.id});

  factory FilteredSlot.fromJson(Map<String, dynamic> json) {
    return _$FilteredSlotFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FilteredSlotToJson(this);
}
