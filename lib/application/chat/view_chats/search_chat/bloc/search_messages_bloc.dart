import 'package:appoint_medic/domain/models/chat_list/get_chat_list_resp_model/get_chat_list_resp_model.dart';
import 'package:appoint_medic/infrastructure/chats/chat_service.dart';
import 'package:bloc/bloc.dart';

part 'search_messages_event.dart';
part 'search_messages_state.dart';

class SearchMessagesBloc
    extends Bloc<SearchMessagesEvent, SearchMessagesState> {
  final ChatService _chatService;
  SearchMessagesBloc(this._chatService) : super(SearchMessagesInitial()) {
    on<SearchMessage>((event, emit) async {
      emit(SearchMessagesLoading());

      final (error, response) = await _chatService.getAllChats();

      if (error.isEmpty) {
        if (response == null) {
          emit(SearchMessagesSucess(searchedMessage: []));
        } else {
          final List<GetChatListRespModel> sortedChatslist = [];

          for (var chat in response) {
            if (chat.latestMessage?.content == null) {
            } else {
              sortedChatslist.add(chat);
            }
          }

          final searchedList = sortedChatslist
              .where((element) => element.participants![0].doctor!.fullName!
                  .toLowerCase()
                  .contains(event.searchKey.toLowerCase()))
              .toList();

          emit(SearchMessagesSucess(searchedMessage: searchedList));
        }
      }
    });

    on<SearchMessageByDoctor>((event, emit) async {
      emit(SearchMessagesLoading());

      final (error, response) = await _chatService.getAllChats();

      if (error.isEmpty) {
        if (response == null) {
          emit(SearchMessagesSucess(searchedMessage: []));
        } else {
          final List<GetChatListRespModel> sortedChatslist = [];

          for (var chat in response) {
            if (chat.latestMessage?.content == null) {
            } else {
              sortedChatslist.add(chat);
            }
          }

          // final searchedList = sortedChatslist
          //     .where((element) => element.participants![0].patient!.name!
          //         .toLowerCase()
          //         .contains(event.searchKey.toLowerCase()))
          //     .toList();

          final searchList = sortedChatslist.where((chat) {
            String? name = chat.participants![0].patient?.fullName ??
                chat.participants![0].patient!.name;

            return name!.toLowerCase().contains(event.searchKey.toLowerCase());
          }).toList();

          emit(SearchMessagesSucess(searchedMessage: searchList));
        }
      }
    });
  }
}
