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
  final Socket socket;

  SendNewMessage({
    required this.message,
    required this.role,
    required this.chatRoomID,
    required this.socket,
  });
}

class ClearMessageEvent extends SeeMessagesEvent {}

class RefreshMessageCall extends SeeMessagesEvent {
  final String chatroom;

  RefreshMessageCall({required this.chatroom});
}
