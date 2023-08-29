// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlot _$AvailableSlotFromJson(Map<String, dynamic> json) =>
    AvailableSlot(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      slots: (json['slots'] as List<dynamic>?)
          ?.map((e) => Slot.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$AvailableSlotToJson(AvailableSlot instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'slots': instance.slots,
      '_id': instance.id,
    };
