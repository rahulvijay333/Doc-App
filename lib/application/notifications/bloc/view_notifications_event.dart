part of 'view_notifications_bloc.dart';

class ViewNotificationsEvent {}

class GetNotifications extends ViewNotificationsEvent {
  final String notificationUserType;

  GetNotifications({required this.notificationUserType});
}

class NotificationMarkRead extends ViewNotificationsEvent {}
