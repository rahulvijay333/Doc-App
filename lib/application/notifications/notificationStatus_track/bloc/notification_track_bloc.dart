import 'package:appoint_medic/infrastructure/notifications/notification_service.dart';
import 'package:bloc/bloc.dart';

part 'notification_track_event.dart';
part 'notification_track_state.dart';

class NotificationTrackBloc
    extends Bloc<NotificationTrackEvent, NotificationTrackState> {
  final NotificationService notificationService;
  NotificationTrackBloc(this.notificationService)
      : super(NotificationTrackState(notificationCount: 0)) {
    on<CheckNotifications>((event, emit) async {
      final (error, response) = await notificationService.getAllNotifications(
          userType: event.userType);

      if (error.isEmpty) {
        if (response == null) {
          emit(NotificationTrackState(notificationCount: 0));
        } else {
          emit(NotificationTrackState(
              notificationCount: response.notification!.length));
        }
      } else {
        emit(NotificationTrackState(notificationCount: 0));
      }
    });

    on<ClearNotifications>((event, emit) {

      emit(NotificationTrackState(notificationCount: 0));
    });
  }
}
