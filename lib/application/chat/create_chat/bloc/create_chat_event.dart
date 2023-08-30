part of 'create_chat_bloc.dart';

class CreateChatEvent {}

class StartChat extends CreateChatEvent {
  final String userID;

  StartChat({required this.userID});
}


class ClearStartChat extends CreateChatEvent {}