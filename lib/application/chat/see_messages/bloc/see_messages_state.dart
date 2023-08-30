part of 'see_messages_bloc.dart';

class SeeMessagesState {}

class SeeMessagesInitial extends SeeMessagesState {}

class MessagesLoading extends SeeMessagesState {}

class MessagesSucess extends SeeMessagesState {
  final List<ChatMessage> messagesList;

  MessagesSucess({required this.messagesList});
}

class MessagesFailed extends SeeMessagesState {}
