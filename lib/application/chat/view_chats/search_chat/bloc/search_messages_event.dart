part of 'search_messages_bloc.dart';

class SearchMessagesEvent {}

class SearchMessage extends SearchMessagesEvent {
  final String searchKey;

  SearchMessage({required this.searchKey});
}
