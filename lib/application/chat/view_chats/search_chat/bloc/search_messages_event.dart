part of 'search_messages_bloc.dart';

class SearchMessagesEvent {}

class SearchMessage extends SearchMessagesEvent {
  final String searchKey;

  SearchMessage({required this.searchKey});
}

class SearchMessageByDoctor extends SearchMessagesEvent {
  final String searchKey;

  SearchMessageByDoctor({required this.searchKey});
}
