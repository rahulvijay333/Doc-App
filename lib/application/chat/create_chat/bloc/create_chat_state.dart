part of 'create_chat_bloc.dart';

class CreateChatState {}

class CreateChatInitial extends CreateChatState {}

class NewChatCreated extends CreateChatState {
  final CreateChatByPatientResponse createdchatDetails;

  NewChatCreated({required this.createdchatDetails});
}

class OldChatCreated extends CreateChatState {
  final GetChatListRespModel oldChatDetails;

  OldChatCreated({required this.oldChatDetails});
}

class CreateChatFailure extends CreateChatState {}

class NewChatCreationLoading extends CreateChatState {}

class CheckingChatsLoading extends CreateChatState {}

class CheckingHistoryLoading extends CreateChatState {}