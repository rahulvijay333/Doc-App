part of 'view_notifications_bloc.dart';

class ViewNotificationsState {}

class ViewNotificationsInitial extends ViewNotificationsState {}

class NotificationsLoading extends ViewNotificationsState {}

class NotificationsSuccess extends ViewNotificationsState {
  final List<Notification> notificationList;

  NotificationsSuccess({required this.notificationList});
}

class NotificationsFailed extends ViewNotificationsState {
  final String error;

  NotificationsFailed(this.error);
}
