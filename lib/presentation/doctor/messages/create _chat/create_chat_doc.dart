import 'package:appoint_medic/application/chat/create_chat_doct/bloc/create_chat_doc_bloc.dart';
import 'package:appoint_medic/application/chat/see_messages/bloc/see_messages_bloc.dart';
import 'package:appoint_medic/presentation/doctor/messages/screen_view_mesg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCreateChatDoc extends StatelessWidget {
  const ScreenCreateChatDoc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       
        body: BlocBuilder<CreateChatDocBloc, CreateChatDocState>(
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
                    return ScreenViewMesgDoctor(
                        patientImage: state.createdchatDetails.participants![0]
                            .patient!.profilePicture!.secureUrl!,
                        chatRoomID: state.createdchatDetails.id!,
                        patientName: state.createdchatDetails.participants![0]
                            .patient!.fullName!,
                        patientID: state
                            .createdchatDetails.participants![0].patient!.id!,
                        doctorID: state
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
                    return ScreenViewMesgDoctor(
                        patientImage: state.oldChatDetails.participants![0]
                            .patient!.profilePicture!.secureUrl!,
                        chatRoomID: state.oldChatDetails.id!,
                        patientName: state
                            .oldChatDetails.participants![0].patient!.fullName!,
                        patientID:
                            state.oldChatDetails.participants![0].patient!.id!,
                        doctorID:
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
