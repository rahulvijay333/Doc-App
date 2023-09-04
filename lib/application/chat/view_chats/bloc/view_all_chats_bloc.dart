import 'dart:developer';

import 'package:appoint_medic/domain/models/chat_list/get_chat_list_resp_model/get_chat_list_resp_model.dart';
import 'package:appoint_medic/infrastructure/chats/chat_service.dart';
import 'package:bloc/bloc.dart';

part 'view_all_chats_event.dart';
part 'view_all_chats_state.dart';

class ViewAllChatsBloc extends Bloc<ViewAllChatsEvent, ViewAllChatsState> {
  final ChatService _chatService;
  ViewAllChatsBloc(this._chatService) : super(ViewAllChatsInitial()) {
    on<GetAllChatsCall>((event, emit) async {
      emit(ViewAllChatsLoading());

      final (error, response) = await _chatService.getAllChats();

      if (error.isEmpty) {
        if (response == null) {
          emit(ViewAllChatsSuccess(chatsList: []));
        } else {
          final List<GetChatListRespModel> sortedChatslist = [];

          for (var chat in response) {
            if (chat.latestMessage?.content == null) {
             
            }else {
               sortedChatslist.add(chat);
            }
          }

          emit(ViewAllChatsSuccess(chatsList: sortedChatslist));
        }
      } else {
        log('Error mesage found in bloc');
        emit(ViewAllChatsFailure(error: 'Error found in viewChatsBloc'));
      }
    });


    
  }
}
