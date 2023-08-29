part of 'see_messages_bloc.dart';

class SeeMessagesEvent {}

class SeeChatsEvent extends SeeMessagesEvent {
  final String chatRoomID;

  SeeChatsEvent({required this.chatRoomID});
}

class SendNewMessage extends SeeMessagesEvent {
  final String message;
  final String role;
  final String chatRoomID;

  SendNewMessage(
      {required this.message, required this.role, required this.chatRoomID});
}

class ClearMessageEvent extends SeeMessagesEvent {}
