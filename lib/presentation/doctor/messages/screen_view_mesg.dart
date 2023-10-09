import 'package:appoint_medic/application/chat/create_chat_doct/bloc/create_chat_doc_bloc.dart';
import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/api_endPoints/base/base_url.dart';

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
        socketUrlOnline,
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
      // Update your UI or trigger a chat refresh

      if (mounted) {
        context
            .read<SeeMessagesBloc>()
            .add(RefreshMessageCall(chatroom: widget.chatRoomID));
      }
    });

    socket.on('message received', (data) {
      // Handle incoming messages
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
            context.read<SeeMessagesBloc>().add(ClearMessageEvent());

            FocusManager.instance.primaryFocus?.unfocus();

            context.read<CreateChatDocBloc>().add(ClearStartChat());

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
                          FocusManager.instance.primaryFocus?.unfocus();

                          context
                              .read<CreateChatDocBloc>()
                              .add(ClearStartChat());

                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: widget.patientImage.isNotEmpty
                              ? Image.network(
                                  widget.patientImage,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/person_placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
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
                          if (state.groupedMessages.isEmpty) {
                            return Center(
                              child: Text('No Conversations'),
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
                              final date =
                                  state.groupedMessages.keys.toList()[index];

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
                                                    'Doctor'
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                messages[index].senderModel ==
                                                        'Doctor'
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Container(

                                                    // width: 160,
                                                    decoration: BoxDecoration(
                                                        borderRadius: messages[index]
                                                                    .senderModel ==
                                                                'Doctor'
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
                                                        color: messages[index].senderModel == 'Doctor' ? Colors.blue : Colors.grey),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8,
                                                              top: 10,
                                                              bottom: 10),
                                                      child: Text(
                                                        messages[index].content,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
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
