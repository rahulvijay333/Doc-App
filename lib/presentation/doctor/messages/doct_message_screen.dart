import 'dart:developer';

import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/bloc/view_all_chats_bloc.dart';
import 'package:appoint_medic/presentation/doctor/messages/screen_view_mesg.dart';
import 'package:appoint_medic/presentation/patient/messages/widget/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreemDoctMessage extends StatelessWidget {
  const ScreemDoctMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    BlocProvider.of<ViewAllChatsBloc>(context).add(GetAllChatsCall());

    // context.read<ViewAllChatsBloc>().add(ViewAllChatsEvent());

    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        // decoration: backgroundDecoration,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                child: const Center(
                  child: Text(
                    'Messages',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),
              //----------------------------------------------------------search messages
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey[200],
                      height: size.height * 0.06,
                      width: size.width * 0.75,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Search Messages..')
                          ],
                        ),
                      ),
                    ),
                  ),

                  //---------------------------------------------new message icon
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: size.height * 0.06,
                      width: size.width * 0.15,
                      color: Colors.blue,
                      child: IconButton(
                          onPressed: () {
                            //----------------------------message function
                          },
                          icon: const Icon(
                            Icons.add_comment,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //-------------------------------list of messages
              Expanded(
                child: BlocBuilder<ViewAllChatsBloc, ViewAllChatsState>(
                  builder: (context, state) {
                    if (state is ViewAllChatsLoading) {
                      return const Center(
                        child: Column(
                          children: [
                            Text('Loading..'),
                            SizedBox(
                              height: 5,
                            ),
                            CircularProgressIndicator(
                              strokeWidth: 1,
                            )
                          ],
                        ),
                      );
                    } else if (state is ViewAllChatsSuccess) {
                      if (state.chatsList.isEmpty) {
                        return Center(
                          child: Text('No Chats'),
                        );
                      }

                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              //------------------------------view message

                              onTap: () {
                                log(state.chatsList[index].id!);
                                context.read<SeeMessagesBloc>().add(
                                    SeeChatsEvent(
                                        chatRoomID:
                                            state.chatsList[index].id!));

                                if (state.chatsList.isNotEmpty) {
                                  //view

                                  log(state.chatsList[index].participants![0]
                                      .patient!.profilePicture!.secureUrl!
                                      .toString());
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      //-------------
                                      return ScreenViewMesgDoctor(
                                        patientImage: state
                                            .chatsList[index]
                                            .participants![0]
                                            .patient!
                                            .profilePicture!
                                            .secureUrl!,
                                        chatRoomID: state.chatsList[index].id!,
                                        patientName: state
                                            .chatsList[index]
                                            .participants![0]
                                            .patient!
                                            .fullName!,
                                      );
                                    },
                                  ));
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    height: size.height * 0.10,
                                    color: Colors.blue[50]?.withOpacity(0.5),
                                    child: MessageTile(
                                      senderName: state.chatsList[index]
                                          .participants![0].patient!.fullName!,
                                      message: state.chatsList[index]
                                              .latestMessage?.content ??
                                          'Send Hi',
                                      time: state.chatsList[index].updatedAt!,
                                      Image: state
                                          .chatsList[index]
                                          .participants![0]
                                          .patient!
                                          .profilePicture!
                                          .secureUrl!,
                                    )),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: state.chatsList.length);
                    } else if (state is ViewAllChatsFailure) {
                      Center(
                        child: Column(
                          children: [
                            Text('Error happened'),
                            SizedBox(
                              height: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  //-------------------------------------refrsh

                                  context
                                      .read<ViewAllChatsBloc>()
                                      .add(ViewAllChatsEvent());
                                },
                                icon: Icon(Icons.refresh))
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: Text('No chats'),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
