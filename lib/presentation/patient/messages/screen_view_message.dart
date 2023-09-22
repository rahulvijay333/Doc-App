import 'dart:developer';

import 'package:appoint_medic/application/chat/create_chat/bloc/create_chat_bloc.dart';
import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/core/color_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ScreenViewMesgPatient extends StatefulWidget {
  ScreenViewMesgPatient(
      {super.key,
      required this.doctImage,
      required this.chatRoomID,
      required this.doctname,
      required this.patientID,
      required this.doctID});

  final String doctImage;
  final String chatRoomID;
  final String doctname;
  final String patientID;
  final String doctID;

  @override
  State<ScreenViewMesgPatient> createState() => _ScreenViewMesgPatientState();
}

class _ScreenViewMesgPatientState extends State<ScreenViewMesgPatient> {
  TextEditingController msgController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;

  @override
  void initState() {
    socket = IO.io(
        socketUrlOnline,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();
    socket.emit('setup', widget.patientID);
    socket.emit('join chat', widget.chatRoomID);

    setUpSocketListener();

    super.initState();
  }

  @override
  void dispose() {
    //-----------------------------bloc call to clear all messages
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  void setUpSocketListener() {
    socket.on('new messages', (data) {
      log('----------------____>>>>New messages received:  when listening to "new messages event');
      // Update your UI or trigger a chat refresh
      context
          .read<SeeMessagesBloc>()
          .add(RefreshMessageCall(chatroom: widget.chatRoomID));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blue.shade100,
        body: WillPopScope(
          onWillPop: () async {
            FocusScope.of(context).unfocus();
            // FocusManager.instance.primaryFocus?.unfocus();
            context.read<SeeMessagesBloc>().add(ClearMessageEvent());
            context.read<CreateChatBloc>().add(ClearStartChat());

            return true;
          },
          child: Column(
            children: [
              //---------------------------------------------appbar
              Container(
                color: appBackGround,
                height: size.height * 0.08,
                child: Center(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          //---------------------go back
                          FocusScope.of(context).unfocus();

                          context
                              .read<SeeMessagesBloc>()
                              .add(ClearMessageEvent());
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue.withOpacity(0.5),
                        backgroundImage: NetworkImage(widget.doctImage),
                        radius: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Dr.${widget.doctname}',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BlocBuilder<SeeMessagesBloc, SeeMessagesState>(
                          builder: (context, state) {
                            if (state is MessagesLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              );
                            } else if (state is MessagesSucess) {
                              if (state.groupedMessages.isEmpty) {
                                return Center(
                                  child: Text(
                                      'Start chat with Dr.${widget.doctname}'),
                                );
                              }
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                // Scroll to the bottom after the ListView updates
                                _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent,
                                );
                              });

                              return ListView.builder(
                                controller: _scrollController,
                                itemCount: state.groupedMessages.length,
                                itemBuilder: (context, index) {
                                  final date = state.groupedMessages.keys
                                      .toList()[index];

                                  final messages = state.groupedMessages[date];

                                  return Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        date,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        itemBuilder: (context, index) {
                                          //--------------------------------------------------format and time

                                          String formattedTime =
                                              DateFormat('h.mm a')
                                                  .format(messages[index]
                                                      .updatedAt
                                                      .toLocal())
                                                  .toLowerCase();

                                          return Column(
                                            crossAxisAlignment:
                                                messages[index].senderModel ==
                                                        'Patient'
                                                    ? CrossAxisAlignment.end
                                                    : CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    messages[index]
                                                                .senderModel ==
                                                            'Patient'
                                                        ? MainAxisAlignment.end
                                                        : MainAxisAlignment
                                                            .start,
                                                children: [
                                                  Flexible(
                                                    child: Container(

                                                        // width: 160,
                                                        decoration: BoxDecoration(
                                                            borderRadius: messages[index]
                                                                        .senderModel ==
                                                                    'Patient'
                                                                ? const BorderRadius.only(
                                                                    topRight:
                                                                        Radius.circular(
                                                                            0),
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15))
                                                                : const BorderRadius.only(
                                                                    topRight:
                                                                        Radius.circular(15),
                                                                    topLeft: Radius.circular(0),
                                                                    bottomLeft: Radius.circular(15),
                                                                    bottomRight: Radius.circular(15)),
                                                            color: messages[index].senderModel == 'Patient' ? Colors.blue : Colors.grey),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8,
                                                                  right: 8,
                                                                  top: 10,
                                                                  bottom: 10),
                                                          child: Text(
                                                            messages[index]
                                                                .content,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '$formattedTime',
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          );
                                        },
                                        itemCount: messages!.length),
                                  ]);
                                },
                              );
                            } else if (state is MessagesFailed) {
                              return Center(
                                child: Column(
                                  children: [
                                    const Text('Refresh'),
                                    InkWell(
                                      onTap: () {
                                        //--------------------------------------------bloc call
                                        context.read<SeeMessagesBloc>().add(
                                            SeeChatsEvent(
                                                chatRoomID: widget.chatRoomID));
                                      },
                                      child: const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return const Center(
                              child: Text(''),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.red.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: appBackGround)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                  controller: msgController,
                                  showCursor: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                      hintText: 'write message here...',
                                      border: InputBorder.none),
                                ),
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  onPressed: () {
                                    //------------------------------------send message function
                                    if (msgController.text.isNotEmpty) {
                                      context.read<SeeMessagesBloc>().add(
                                          SendNewMessage(
                                              message: msgController.text,
                                              role: 'Patient',
                                              chatRoomID: widget.chatRoomID,
                                              socket: socket));
                                    }
                                    msgController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
