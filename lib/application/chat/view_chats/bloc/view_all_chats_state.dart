part of 'view_all_chats_bloc.dart';

class ViewAllChatsState {}

class ViewAllChatsInitial extends ViewAllChatsState {}

class ViewAllChatsLoading extends ViewAllChatsState {}

class ViewAllChatsSuccess extends ViewAllChatsState {
  final List<GetChatListRespModel> chatsList;

  ViewAllChatsSuccess({required this.chatsList});
}

class ViewAllChatsFailure extends ViewAllChatsState {
  final String error;

  ViewAllChatsFailure({required this.error});
}
