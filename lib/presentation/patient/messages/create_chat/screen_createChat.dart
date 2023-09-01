import 'package:appoint_medic/application/chat/create_chat/bloc/create_chat_bloc.dart';
import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/presentation/patient/messages/screen_view_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCreateChat extends StatelessWidget {
  const ScreenCreateChat({super.key, required this.doctorID});

  final String doctorID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CreateChatBloc, CreateChatState>(
          builder: (context, state) {
            if (state is CheckingChatsLoading) {
              return const Center(child: Text('Checking Chat status...'));
            } else if (state is NewChatCreationLoading) {
              return const Center(
                  child: Text(
                      'starting new conversation with doctor , please wait'));
            } else if (state is NewChatCreated) {
              context
                  .read<SeeMessagesBloc>()
                  .add(SeeChatsEvent(chatRoomID: state.createdchatDetails.id!));
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return ScreenViewMesgPatient(
                        doctImage: state.createdchatDetails.participants![0]
                            .doctor!.profilePicture!.secureUrl!,
                        chatRoomID: state.createdchatDetails.id!,
                        doctname: state.createdchatDetails.participants![0]
                            .doctor!.fullName!,
                        patientID: state
                            .createdchatDetails.participants![0].patient!.id!,
                        doctID: state
                            .createdchatDetails.participants![0].doctor!.id!);
                  },
                ));
              });
            } else if (state is OldChatCreated) {
              context
                  .read<SeeMessagesBloc>()
                  .add(SeeChatsEvent(chatRoomID: state.oldChatDetails.id!));
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return ScreenViewMesgPatient(
                        doctImage: state.oldChatDetails.participants![0].doctor!
                            .profilePicture!.secureUrl!,
                        chatRoomID: state.oldChatDetails.id!,
                        doctname: state
                            .oldChatDetails.participants![0].doctor!.fullName!,
                        patientID:
                            state.oldChatDetails.participants![0].patient!.id!,
                        doctID:
                            state.oldChatDetails.participants![0].doctor!.id!);
                  },
                ));
              });
            } else if (state is CreateChatFailure) {
              return const Center(
                  child: Text('chat with doctor failed, try lator'));
            }

            return const Center(child: Text('chat with doctor'));
          },
        ),
      ),
    );
  }
}
