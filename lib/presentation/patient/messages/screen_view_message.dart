import 'dart:developer';

import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ScreenViewMesgPatient extends StatefulWidget {
  ScreenViewMesgPatient(
      {super.key,
      required this.doctImage,
      required this.chatRoomID,
      required this.doctname});

  final String doctImage;
  final String chatRoomID;
  final String doctname;

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
        'http://100.26.104.81:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();
    setUpSocketListener();

    super.initState();
  }

  @override
  void dispose() {
    //-----------------------------bloc call to clear all messages

    super.dispose();
  }

  void setUpSocketListener() {
    socket.on('message recieved', (data) {
      log('some message update is going on....');
      print(data);
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

            return true;
          },
          child: Column(
            children: [
              //---------------------------------------------appbar
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
                        backgroundImage: NetworkImage(widget.doctImage),
                        radius: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Dr.${widget.doctname}',
                        style: TextStyle(
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
                        child: Container(
                          // color: Colors.amber,
                          child: BlocBuilder<SeeMessagesBloc, SeeMessagesState>(
                            builder: (context, state) {
                              if (state is MessagesSucess) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  // Scroll to the bottom after the ListView updates
                                  _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent,
                                  );
                                });
                                return ListView.separated(
                                    keyboardDismissBehavior:
                                        ScrollViewKeyboardDismissBehavior
                                            .onDrag,
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment: state
                                                    .messagesList[index]
                                                    .senderModel ==
                                                'Patient'
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Container(

                                                // width: 160,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: state
                                                                .messagesList[
                                                                    index]
                                                                .senderModel ==
                                                            'Patient'
                                                        ? Colors.blue
                                                        : Colors.grey),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 10,
                                                          bottom: 10),
                                                  child: Text(
                                                    state.messagesList[index]
                                                        .content,
                                                    style: const TextStyle(
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
                              } else {
                                return const Center(
                                  child: Text('Send hi'),
                                );
                              }
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
                                              chatRoomID: widget.chatRoomID));
                                    }
                                    msgController.clear();
                                    _scrollController.jumpTo(_scrollController
                                        .position.maxScrollExtent);
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
                    SizedBox(
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
