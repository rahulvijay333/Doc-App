import 'dart:developer';

import 'package:appoint_medic/domain/models/chat_list/chatmessages_parsing/chat_messags.dart';
import 'package:appoint_medic/infrastructure/chats/chat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
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
        
        if (response == null) {
          emit(MessagesSucess( groupedMessages: {}));
        } else {
          //------------------------------------------------------------creating a map of date and messages
          Map<String, List<ChatMessage>> groupedChatMessages = {};

          for (var mesg in response) {
            String date = DateFormat('dd MMM yyyy').format(mesg.createdAt);
            if (!groupedChatMessages.containsKey(date)) {
              groupedChatMessages[date] = [];
            }

            groupedChatMessages[date]!.add(mesg);
          }
          //---------------sorting according to date
          groupedChatMessages.forEach((date, messages) {
            messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          });

          emit(MessagesSucess(
              groupedMessages: groupedChatMessages));
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
       
        Map<String, List<ChatMessage>> groupedChatMessages = {};

        if (response != null) {
          for (var mesg in response) {
            String date = DateFormat('dd MMM yyyy').format(mesg.createdAt);
            if (!groupedChatMessages.containsKey(date)) {
              groupedChatMessages[date] = [];
            }

            groupedChatMessages[date]!.add(mesg);
          }
        
        } 

          //---------------sorting according to date
          groupedChatMessages.forEach((date, messages) {
            messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

            emit(MessagesSucess(
                 groupedMessages: groupedChatMessages));
          });
        
      } else {
        emit(MessagesFailed());
      }
    });

    on<ClearMessageEvent>((event, emit) {
      emit(SeeMessagesInitial());
    });
  }
}
