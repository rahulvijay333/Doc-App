import 'dart:developer';

import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ScreenViewMesgDoctor extends StatefulWidget {
  ScreenViewMesgDoctor(
      {super.key,
      required this.patientImage,
      required this.chatRoomID,
      required this.patientName});

  final String patientImage;
  final String chatRoomID;
  final String patientName;

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
        'http://192.168.1.152:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();
    setUpSocketListener();

    super.initState();
  }

  void setUpSocketListener() {
    socket.on('message recieved', (data) {
      log('some message update is going on....');
      print(data);
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log("patient url is ${widget.patientImage}");
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blue.shade100,
        body: Column(
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
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.patientName}',
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // color: Colors.amber,
                  child: BlocBuilder<SeeMessagesBloc, SeeMessagesState>(
                    builder: (context, state) {
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: state.messagesList[index]
                                                        .senderModel ==
                                                    'Doctor'
                                                ? Colors.blue
                                                : Colors.grey),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 5,
                                              bottom: 5),
                                          child: Text(
                                            state.messagesList[index].content,
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
                          onPressed: () {
                            //------------------------------------send message function
                            if (msgController.text.isNotEmpty) {
                              context.read<SeeMessagesBloc>().add(
                                  SendNewMessage(
                                      message: msgController.text,
                                      role: 'Doctor',
                                      chatRoomID: widget.chatRoomID));
                            }
                            msgController.clear();
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
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
    );
  }
}
