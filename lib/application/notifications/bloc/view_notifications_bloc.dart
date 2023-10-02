import 'dart:developer';

import 'package:appoint_medic/domain/models/notifications/notification_response/notification.dart';
import 'package:appoint_medic/infrastructure/notifications/notification_service.dart';
import 'package:bloc/bloc.dart';

part 'view_notifications_event.dart';
part 'view_notifications_state.dart';

class ViewNotificationsBloc
    extends Bloc<ViewNotificationsEvent, ViewNotificationsState> {
  final NotificationService notificationService;
  ViewNotificationsBloc(this.notificationService)
      : super(ViewNotificationsInitial()) {
    on<GetNotifications>((event, emit) async {
      //-----------------------------------------------loading
      emit(NotificationsLoading());

      //-----------------------------------------------getting notifications
      final (error, response) = await notificationService.getAllNotifications(
          userType: event.notificationUserType);

      //-------------------------------------------------handle ui based on result
      if (error.isEmpty) {
        if (response!.notification!.isEmpty) {
          emit(NotificationsSuccess(notificationList: []));
        } else {
          emit(NotificationsSuccess(notificationList: response.notification!));
        }
      } else {
        emit(NotificationsFailed('Error happened While Checking Notification'));
      }
    });

    on<NotificationMarkRead>((event, emit) async {
      final response = await notificationService.markReadNotification();

      if (response.isEmpty) {
      } else {}
    });
  }
}
