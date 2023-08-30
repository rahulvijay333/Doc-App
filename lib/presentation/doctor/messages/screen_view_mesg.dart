import 'dart:convert';
import 'dart:developer';

import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/domain/response_models/new_message/new_chat_response/new_chat_response.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ScreenViewMesgDoctor extends StatefulWidget {
  ScreenViewMesgDoctor(
      {super.key,
      required this.patientImage,
      required this.chatRoomID,
      required this.patientName,
      required this.doctorID,
      required this.patientID});

  final String patientImage;
  final String chatRoomID;
  final String patientName;
  final String doctorID;
  final String patientID;

  @override
  State<ScreenViewMesgDoctor> createState() => _ScreenViewMesgDoctorState();
}

class _ScreenViewMesgDoctorState extends State<ScreenViewMesgDoctor> {
  TextEditingController msgController = TextEditingController();

  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;

  @override
  void initState() {
    socket = IO.io(
        'http://100.26.104.81:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();
    socket.emit('setup', widget.doctorID);
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

      if (mounted) {
        context
            .read<SeeMessagesBloc>()
            .add(RefreshMessageCall(chatroom: widget.chatRoomID));
      }
    });

    socket.on('message received', (data) {
      // Handle incoming messages
      log('Received message: $data');
      log('----------------____>>>>message received:  when listening to "message received');
    });
  }

  @override
  Widget build(BuildContext context) {
    // log("patient url is ${widget.patientImage}");
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blue.shade100,
        body: WillPopScope(
          onWillPop: () async {
            context.read<SeeMessagesBloc>().add(ClearMessageEvent());

            return true;
          },
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                height: size.height * 0.08,
                child: Center(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          //---------------------go back
                          context
                              .read<SeeMessagesBloc>()
                              .add(ClearMessageEvent());
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue.withOpacity(0.5),
                        backgroundImage: NetworkImage(widget.patientImage),
                        radius: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.patientName,
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    // color: Colors.amber,
                    child: BlocBuilder<SeeMessagesBloc, SeeMessagesState>(
                      builder: (context, state) {
                        if (state is MessagesLoading) {
                          return Center(
                            child: Text('Loading...'),
                          );
                        }

                        if (state is MessagesSucess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            // Scroll to the bottom after the ListView updates
                            _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent,
                            );
                          });

                          return ListView.separated(
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      state.messagesList[index].senderModel ==
                                              'Doctor'
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                          // width: 160,
                                          decoration: BoxDecoration(
                                              borderRadius: state
                                                          .messagesList[index]
                                                          .senderModel ==
                                                      'Doctor'
                                                  ? const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(0),
                                                      topLeft:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15))
                                                  : const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      topLeft:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15)),
                                              color: state.messagesList[index]
                                                          .senderModel ==
                                                      'Doctor'
                                                  ? Colors.blue
                                                  : Colors.grey),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            child: Text(
                                              state.messagesList[index].content,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 15,
                                );
                              },
                              itemCount: state.messagesList.length);
                        } else if (state is MessagesFailed) {
                          Center(
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
                            border: Border.all(color: Colors.blue)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: msgController,
                            showCursor: true,
                            enabled: true,
                            decoration: const InputDecoration(
                                hintText: 'message here...',
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
                            onPressed: () async {
                              // await handleMessageSent();
                              //------------------------------------send message function
                              if (msgController.text.isNotEmpty) {
                                context.read<SeeMessagesBloc>().add(
                                    SendNewMessage(
                                        message: msgController.text,
                                        role: 'Doctor',
                                        chatRoomID: widget.chatRoomID,
                                        socket: socket));
                              }
                              msgController.clear();
                              _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent);

                              //
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
      ),
    );
  }
}
