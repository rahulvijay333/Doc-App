part of 'see_messages_bloc.dart';

class SeeMessagesState {}

class SeeMessagesInitial extends SeeMessagesState {}

class MessagesLoading extends SeeMessagesState {}

class MessagesSucess extends SeeMessagesState {
  // final List<ChatMessage> messagesList;
  final Map<String, List<ChatMessage>> groupedMessages;

  MessagesSucess({ required this.groupedMessages});
}

class MessagesFailed extends SeeMessagesState {}
