import 'package:json_annotation/json_annotation.dart';

import 'filtered_slot.dart';

part 'available_slot_response.g.dart';

@JsonSerializable()
class AvailableSlotResponse {
  List<FilteredSlot>? filteredSlots;

  AvailableSlotResponse({this.filteredSlots});

  factory AvailableSlotResponse.fromJson(Map<String, dynamic> json) {
    return _$AvailableSlotResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AvailableSlotResponseToJson(this);
}
