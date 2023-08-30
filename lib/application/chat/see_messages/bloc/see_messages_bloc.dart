import 'dart:developer';

import 'package:appoint_medic/domain/models/chat_list/chatmessages_parsing/chat_messags.dart';
import 'package:appoint_medic/infrastructure/chats/chat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'see_messages_event.dart';
part 'see_messages_state.dart';

//------------------view all messages history inside side
class SeeMessagesBloc extends Bloc<SeeMessagesEvent, SeeMessagesState> {
  final ChatService _chatService;
  SeeMessagesBloc(this._chatService) : super(SeeMessagesInitial()) {
    on<SeeChatsEvent>((event, emit) async {
      emit(MessagesLoading());
      final (error, response) =
          await _chatService.getAllMesssages(chatRoomId: event.chatRoomID);

      if (error.isEmpty) {
        // log(response.toString());
        if (response == null) {
          emit(MessagesSucess(messagesList: []));
        } else {
          emit(MessagesSucess(messagesList: response));
        }
      } else {
        emit(MessagesFailed());
      }
    });

    on<SendNewMessage>((event, emit) async {
      final (error, response) = await _chatService.sendNewMessage(
          message: event.message,
          role: event.role,
          chatRoomID: event.chatRoomID);

      if (error.isEmpty) {
        add(RefreshMessageCall(chatroom: event.chatRoomID));
        event.socket.emit('new message', response);
      } else {
        log('error sending message');
      }
    });

    on<RefreshMessageCall>((event, emit) async {
      final (error, response) =
          await _chatService.getAllMesssages(chatRoomId: event.chatroom);

      if (error.isEmpty) {
        // log(response.toString());

        emit(MessagesSucess(messagesList: response!));
      } else {
        emit(MessagesFailed());
      }
    });

    on<ClearMessageEvent>((event, emit) {
      emit(SeeMessagesInitial());
    });
  }
}
