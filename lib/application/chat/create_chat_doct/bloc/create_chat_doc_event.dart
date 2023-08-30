part of 'create_chat_doc_bloc.dart';

@immutable
sealed class CreateChatDocEvent {}

class StartChat extends CreateChatDocEvent {
  final String userID;

  StartChat({required this.userID});
}

class ClearStartChat extends CreateChatDocEvent {}
