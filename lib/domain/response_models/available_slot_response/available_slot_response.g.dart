// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlotResponse _$AvailableSlotResponseFromJson(
        Map<String, dynamic> json) =>
    AvailableSlotResponse(
      filteredSlots: (json['filteredSlots'] as List<dynamic>?)
          ?.map((e) => FilteredSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvailableSlotResponseToJson(
        AvailableSlotResponse instance) =>
    <String, dynamic>{
      'filteredSlots': instance.filteredSlots,
    };
