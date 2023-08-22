import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'booking_initization_response.g.dart';

//----------------------------------------------used for getting order details
@JsonSerializable()
class BookingInitizationResponse {
  Order? order;

  BookingInitizationResponse({this.order});

  factory BookingInitizationResponse.fromJson(Map<String, dynamic> json) {
    return _$BookingInitizationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookingInitizationResponseToJson(this);
}
