import 'package:appoint_medic/application/notifications/bloc/view_notifications_bloc.dart';
import 'package:appoint_medic/application/notifications/notificationStatus_track/bloc/notification_track_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScreenNotification extends StatelessWidget {
  const ScreenNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          context.read<ViewNotificationsBloc>().add(NotificationMarkRead());

          context.read<NotificationTrackBloc>().add(ClearNotifications());

          Navigator.of(context).pop();

          return true;
        },
        child: Scaffold(
          body: Column(
            children: [
              //--------------------custom app bar
              Container(
                width: size.width,
                height: size.height * 0.07,
                color: appBackGround,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          //--------      context
                          context
                              .read<ViewNotificationsBloc>()
                              .add(NotificationMarkRead());
                          context
                              .read<NotificationTrackBloc>()
                              .add(ClearNotifications());

                          //---------------------pop function

                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                     Text(
                      'Notifications',
                      style: TextStyle(fontSize: size.width * 0.04, color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Expanded(
                child:
                    BlocBuilder<ViewNotificationsBloc, ViewNotificationsState>(
                  builder: (context, state) {
                    if (state is NotificationsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      );
                    }

                    if (state is NotificationsSuccess) {
                      if (state.notificationList.isEmpty) {
                        return const Center(
                          child: Text('No Notifications'),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: size.height * 0.10,
                                  color: Colors.blue.withOpacity(0.2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr.${state.notificationList[index].sender?.name}',
                                          style: TextStyle(
                                              fontSize: size.width * 0.045,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${state.notificationList[index].message}',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        Row(
                                          children: [
                                            const Spacer(),
                                            Text(
                                              '${DateFormat('dd MMM,yyyy').format(state.notificationList[index].createdAt!)} ,${DateFormat("h.mm a").format(state.notificationList[index].createdAt!.toLocal()).toLowerCase()}',
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                            itemCount: state.notificationList.length),
                      );
                    } else if (state is NotificationsFailed) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return const Center(
                      child: Text('No Notifactions'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
