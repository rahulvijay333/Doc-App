import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/application/chat/view_chats/search_chat/bloc/search_messages_bloc.dart';
import 'package:appoint_medic/presentation/doctor/messages/screen_view_mesg.dart';
import 'package:appoint_medic/presentation/patient/messages/widget/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSearchMesgsDoctor extends StatelessWidget {
  const ScreenSearchMesgsDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Expanded(
      child: BlocBuilder<SearchMessagesBloc, SearchMessagesState>(
        builder: (context, state) {
          if (state is SearchMessagesSucess) {
            if (state.searchedMessage.isEmpty) {
              return const Center(
                child: Text('No Chats'),
              );
            }

            return ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    //------------------------------view ----------------------sending to view messages screen

                    onTap: () {
                      context.read<SeeMessagesBloc>().add(SeeChatsEvent(
                          chatRoomID: state.searchedMessage[index].id!));

                      if (state.searchedMessage.isNotEmpty) {
                        //view
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            //-------------
                            return ScreenViewMesgDoctor(
                              patientImage: state
                                  .searchedMessage[index]
                                  .participants![0]
                                  .patient!
                                  .profilePicture!
                                  .secureUrl!,
                              chatRoomID: state.searchedMessage[index].id!,
                              patientName: state.searchedMessage[index]
                                  .participants![0].patient!.fullName!,
                              patientID: state.searchedMessage[index]
                                  .participants![0].patient!.id!,
                              doctorID: state.searchedMessage[index]
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
                          color: Colors.blue[50]?.withOpacity(0.5),
                          child: MessageTile(
                            senderName:
                                "${state.searchedMessage[index].participants![0].patient?.fullName ?? state.searchedMessage[index].participants![0].patient!.name}",
                            message: state.searchedMessage[index].latestMessage
                                    ?.content ??
                                'Send Hi',
                            time: state.searchedMessage[index].updatedAt!,
                            Image: state.searchedMessage[index].participants![0]
                                .patient!.profilePicture!.secureUrl!,
                          )),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: state.searchedMessage.length);
          } else if (state is SearchMessagesFailure) {
            const Center(
              child: Text('Search Error, try lator'),
            );
          }
          return const Center(
            child: Text('Searching..'),
          );
        },
      ),
    );
  }
}
