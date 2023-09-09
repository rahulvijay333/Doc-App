import 'dart:developer';

import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/bloc/view_all_chats_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/search_chat/bloc/search_messages_bloc.dart';
import 'package:appoint_medic/presentation/doctor/messages/screen_view_mesg.dart';
import 'package:appoint_medic/presentation/doctor/messages/search_message/screen_seach_msg.dart';
import 'package:appoint_medic/presentation/patient/messages/widget/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreemDoctMessage extends StatelessWidget {
  ScreemDoctMessage(
      {super.key,
      required this.searchController,
      required this.searchnotifier});
  final TextEditingController searchController;

  final ValueNotifier<String> searchnotifier;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    BlocProvider.of<ViewAllChatsBloc>(context).add(GetAllChatsCall());

    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        // decoration: backgroundDecoration,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: size.height * 0.07,
              child: const Center(
                child: Text(
                  'Messages',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    //----------------------------------------------------------search messages
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        height: size.height * 0.068,
                        width: size.width,
                        child: Center(
                          child: TextFormField(
                            controller: searchController,
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search messages...',
                                hintStyle: TextStyle(),
                                border: InputBorder.none),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                // FocusScope.of(context).unfocus();
              
                             
                                BlocProvider.of<ViewAllChatsBloc>(context)
                                    .add(GetAllChatsCall());
                                searchnotifier.value = value;
                              } else {
                                searchnotifier.value = value;
                                searchnotifier.notifyListeners();
              
                                context.read<SearchMessagesBloc>().add(
                                    SearchMessageByDoctor(
                                        searchKey: searchController.text));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //-------------------------------list of messages
                    ValueListenableBuilder(
                      valueListenable: searchnotifier,
                      builder: (context, searchValue, child) {
                        if (searchValue.isNotEmpty) {
                          return const ScreenSearchMesgsDoctor();
                        } else {
                          return Expanded(
                            child: BlocBuilder<ViewAllChatsBloc,
                                ViewAllChatsState>(
                              builder: (context, state) {
                                if (state is ViewAllChatsLoading) {
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    return const Center(
                                      child: Text('No Chats'),
                                    );
                                  }
              
                                  return ListView.separated(
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          //------------------------------view message
              
                                          onTap: () {
                                            context.read<SeeMessagesBloc>().add(
                                                SeeChatsEvent(
                                                    chatRoomID: state
                                                        .chatsList[index].id!));
              
                                            if (state.chatsList.isNotEmpty) {
                                              //view
              
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) {
                                                  //-------------
                                                  return ScreenViewMesgDoctor(
                                                    patientImage: state
                                                        .chatsList[index]
                                                        .participants![0]
                                                        .patient!
                                                        .profilePicture!
                                                        .secureUrl!,
                                                    chatRoomID: state
                                                        .chatsList[index].id!,
                                                    patientName: state
                                                        .chatsList[index]
                                                        .participants![0]
                                                        .patient!
                                                        .fullName!,
                                                    doctorID: state
                                                        .chatsList[index]
                                                        .participants![0]
                                                        .doctor!
                                                        .id!,
                                                    patientID: state
                                                        .chatsList[index]
                                                        .participants![0]
                                                        .patient!
                                                        .id!,
                                                  );
                                                },
                                              ));
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                                height: size.height * 0.10,
                                                // color: Colors.blue[50]?.withOpacity(0.5),
                                                child: MessageTile(
                                                  senderName: state
                                                      .chatsList[index]
                                                      .participants![0]
                                                      .patient!
                                                      .fullName!,
                                                  message: state
                                                          .chatsList[index]
                                                          .latestMessage
                                                          ?.content ??
                                                      '',
                                                  time: state.chatsList[index]
                                                      .updatedAt!,
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
                                        const Text('Error happened'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              //-------------------------------------refrsh
              
                                              context
                                                  .read<ViewAllChatsBloc>()
                                                  .add(ViewAllChatsEvent());
                                            },
                                            icon: const Icon(Icons.refresh))
                                      ],
                                    ),
                                  );
                                }
                                return const Center(
                                  child: Text('No chats'),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
