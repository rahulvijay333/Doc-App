part of 'view_all_chats_bloc.dart';

class ViewAllChatsEvent {}

class GetAllChatsCall extends ViewAllChatsEvent {}

class SearchMessages extends ViewAllChatsEvent {
  final String searchKey;
  final List<GetChatListRespModel> messageList;

  SearchMessages({required this.searchKey, required this.messageList});
}
