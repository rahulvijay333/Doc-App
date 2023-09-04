part of 'notification_track_bloc.dart';

class NotificationTrackEvent {}

class CheckNotifications extends NotificationTrackEvent {
  final String userType;

  CheckNotifications({required this.userType});
}

class ClearNotifications extends NotificationTrackEvent {
  
}
