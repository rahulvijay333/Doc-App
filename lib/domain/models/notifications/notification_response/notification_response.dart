import 'package:json_annotation/json_annotation.dart';

import 'notification.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  List<Notification>? notification;

  NotificationResponse({this.notification});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return _$NotificationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
