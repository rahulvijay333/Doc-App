// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_initization_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingInitizationResponse _$BookingInitizationResponseFromJson(
        Map<String, dynamic> json) =>
    BookingInitizationResponse(
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingInitizationResponseToJson(
        BookingInitizationResponse instance) =>
    <String, dynamic>{
      'order': instance.order,
    };
