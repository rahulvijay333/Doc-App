import 'dart:developer';

import 'package:appoint_medic/domain/models/chat_list/create_chat_by_patient_response/create_chat_by_patient_response.dart';
import 'package:appoint_medic/domain/models/chat_list/get_chat_list_resp_model/get_chat_list_resp_model.dart';
import 'package:appoint_medic/infrastructure/chats/chat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_chat_event.dart';
part 'create_chat_state.dart';

class CreateChatBloc extends Bloc<CreateChatEvent, CreateChatState> {
  final ChatService chatService;
  CreateChatBloc(this.chatService) : super(CreateChatInitial()) {
    on<StartChat>((event, emit) async {
      //------------------------------------loading state
      log('create chat loading');
      emit(CheckingChatsLoading());

      //---------------------------searching state

      final (error, response) = await chatService.getAllChats();

      if (error.isEmpty) {
        //  var value = response!
        //       .where((chat) => chat.participants!.contains(event.userID)).toList();

        // log("chat room id : is  ${value.toString()}");
        GetChatListRespModel? found;

        for (var response in response!) {
          if (response.participants != null) {
            for (var participant in response.participants!) {
              if (participant.doctor?.id == event.userID) {
                found = response;
              }
            }
          }
        }

        if (found == null) {
          emit(NewChatCreationLoading());
          final (createError, createResponse) =
              await chatService.createNewChatByPatient(doctorID: event.userID);

          if (createError.isEmpty) {
            emit(NewChatCreated(createdchatDetails: createResponse!));
          } else {
            emit(CreateChatFailure());
          }

          log('No chat room found');
        } else {
          emit(CheckingHistoryLoading());
          log('chat room found');
          log(found.id.toString());

          emit(OldChatCreated(oldChatDetails: found));
        }
      }
    });

    on<ClearStartChat>((event, emit) {
      emit(CreateChatInitial());
    });
  }
}
