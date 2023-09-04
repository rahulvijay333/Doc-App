part of 'search_messages_bloc.dart';

class SearchMessagesState {}

class SearchMessagesInitial extends SearchMessagesState {}

class SearchMessagesLoading extends SearchMessagesState {}

class SearchMessagesSucess extends SearchMessagesState {
  final List<GetChatListRespModel> searchedMessage;

  SearchMessagesSucess({required this.searchedMessage});
}

class SearchMessagesFailure extends SearchMessagesState {}
