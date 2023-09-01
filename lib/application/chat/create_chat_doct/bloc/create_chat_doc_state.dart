part of 'create_chat_doc_bloc.dart';

@immutable
sealed class CreateChatDocState {}

final class CreateChatDocInitial extends CreateChatDocState {}

class NewChatCreated extends CreateChatDocState {
  final CreateChatByPatientResponse createdchatDetails;

  NewChatCreated({required this.createdchatDetails});
}

class OldChatCreated extends CreateChatDocState {
  final GetChatListRespModel oldChatDetails;

  OldChatCreated({required this.oldChatDetails});
}

class CreateChatFailure extends CreateChatDocState {}

class NewChatCreationLoading extends CreateChatDocState {}

class CheckingChatsLoading extends CreateChatDocState {}

class CheckingHistoryLoading extends CreateChatDocState {}
