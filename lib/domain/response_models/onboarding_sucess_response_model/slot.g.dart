// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slot _$SlotFromJson(Map<String, dynamic> json) => Slot(
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      status: json['status'] as bool?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
      '_id': instance.id,
    };
