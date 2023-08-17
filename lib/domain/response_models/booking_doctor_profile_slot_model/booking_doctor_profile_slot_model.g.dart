// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_doctor_profile_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDoctorProfileSlotModel _$BookingDoctorProfileSlotModelFromJson(
        Map<String, dynamic> json) =>
    BookingDoctorProfileSlotModel(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingDoctorProfileSlotModelToJson(
        BookingDoctorProfileSlotModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };
