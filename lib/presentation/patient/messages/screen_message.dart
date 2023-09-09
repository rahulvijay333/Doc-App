import 'dart:developer';

import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/bloc/view_all_chats_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/search_chat/bloc/search_messages_bloc.dart';
import 'package:appoint_medic/core/color_constants.dart';
import 'package:appoint_medic/presentation/patient/messages/screen_view_message.dart';
import 'package:appoint_medic/presentation/patient/messages/search_results.dart';
import 'package:appoint_medic/presentation/patient/messages/widget/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenMesgsPatient extends StatelessWidget {
  const ScreenMesgsPatient(
      {super.key,
      required this.searchController,
      required this.searchnotifier});

  final TextEditingController searchController;

  final ValueNotifier<String> searchnotifier;

  @override
  Widget build(BuildContext context) {
  
    final size = MediaQuery.sizeOf(context);

    BlocProvider.of<ViewAllChatsBloc>(context).add(GetAllChatsCall());

    return SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        // decoration: backgroundDecoration,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                child: Center(
                  child: Text(
                    'Messages',
                    style: TextStyle(
                        fontSize: 25,
                        color: appBackGround,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),
              //----------------------------------------------------------search messages
              ClipRRect(
                // borderRadius: BorderRadius.circular(0),
                child: Container(
                  color: Colors.white,
                  height: size.height * 0.068,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search messages...',
                          hintStyle: TextStyle(),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          FocusScope.of(context).unfocus();

                     
                          BlocProvider.of<ViewAllChatsBloc>(context)
                              .add(GetAllChatsCall());
                          searchnotifier.value = value;
                        } else {
                          searchnotifier.value = value;
                          searchnotifier.notifyListeners();
                         

                          context.read<SearchMessagesBloc>().add(
                              SearchMessage(searchKey: searchController.text));
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
              // searchnotifier.value.isEmpty ?

              ValueListenableBuilder(
                valueListenable: searchnotifier,
                builder: (context, searchValue, child) {
                  if (searchValue.isNotEmpty) {
                  

                    return const ScreenSearchMesgsPatient();
                  } else {
                  
                    return Expanded(
                      child: BlocBuilder<ViewAllChatsBloc, ViewAllChatsState>(
                        builder: (context, state) {
                          if (state is ViewAllChatsLoading) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    //------------------------------view ----------------------sending to view messages screen

                                    onTap: () {
                                      context.read<SeeMessagesBloc>().add(
                                          SeeChatsEvent(
                                              chatRoomID:
                                                  state.chatsList[index].id!));

                                      if (state.chatsList.isNotEmpty) {
                                        //view
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            //-------------
                                            return ScreenViewMesgPatient(
                                              doctImage: state
                                                  .chatsList[index]
                                                  .participants![0]
                                                  .doctor!
                                                  .profilePicture!
                                                  .secureUrl!,
                                              chatRoomID:
                                                  state.chatsList[index].id!,
                                              doctname: state
                                                  .chatsList[index]
                                                  .participants![0]
                                                  .doctor!
                                                  .fullName!,
                                              patientID: state
                                                  .chatsList[index]
                                                  .participants![0]
                                                  .patient!
                                                  .id!,
                                              doctID: state.chatsList[index]
                                                  .participants![0].doctor!.id!,
                                            );
                                          },
                                        ));
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        
                                          height: size.height * 0.10,
                                          color:
                                              appBackGround.withOpacity(0.5),
                                          child: MessageTile(
                                            senderName:
                                                "Dr.${state.chatsList[index].participants![0].doctor!.fullName!}",
                                            message: state.chatsList[index]
                                                    .latestMessage?.content ??
                                                'Send Hi',
                                            time: state
                                                .chatsList[index].updatedAt!,
                                            Image: state
                                                .chatsList[index]
                                                .participants![0]
                                                .doctor!
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
              )
            ],
          ),
        ));
  }
}
