import 'package:appoint_medic/application/notifications/bloc/view_notifications_bloc.dart';
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

                        //---------------------pop function

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Expanded(
              child: BlocBuilder<ViewNotificationsBloc, ViewNotificationsState>(
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
                            return Container(
                              height: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dr.${state.notificationList[index].sender?.name}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  Text(
                                      '${state.notificationList[index].message}'),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Text(
                                        '${DateFormat('dd MMM,yyyy').format(state.notificationList[index].createdAt!)} ,${DateFormat("h.mm a").format(state.notificationList[index].createdAt!).toLowerCase()}',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
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
    );
  }
}
