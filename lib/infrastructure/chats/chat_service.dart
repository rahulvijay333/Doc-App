import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/models/chat_list/chatmessages_parsing/chat_messags.dart';
import 'package:appoint_medic/domain/models/chat_list/create_chat_by_patient_response/create_chat_by_patient_response.dart';
import 'package:appoint_medic/domain/models/chat_list/get_chat_list_resp_model/get_chat_list_resp_model.dart';
import 'package:appoint_medic/domain/response_models/new_message/new_chat_response/new_chat_response.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';

class ChatService {
//get existing chats by patient

  Future<(String, List<GetChatListRespModel>?)> getAllChats() async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final Response response = await Dio().get(ApiEndPoints.getAllChats,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      if (response.statusCode == 200) {
        List<GetChatListRespModel> chatList =
            GetChatListRespModel.fromJsonList(response.data);

        return ("", chatList);
      } else {
        return ("Return other error code service", null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response!.statusCode == 404) {
        
          return ('', null);
        } else if (e.response!.statusCode == 500) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      } else {
        return ('Api call Error in Booking service', null);
      }
    }
  }

  Future<(String, CreateChatByPatientResponse?)> createNewChatByDoctor(
      {required String patientID}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
   

      final Response response =
          await Dio().post('${ApiEndPoints.createNewChatByDoc}/$patientID',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

     

      if (response.statusCode == 200 || response.statusCode == 201) {
      

        return ("", CreateChatByPatientResponse.fromJson(response.data));
      } else {
        return ("Return other error code service", null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response!.statusCode == 500) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      } else {
        return ('Api call Error in Booking service', null);
      }
    }
  }

  Future<(String, CreateChatByPatientResponse?)> createNewChatByPatient(
      {required String doctorID}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final Response response =
          await Dio().post('${ApiEndPoints.createNewChat}/$doctorID',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ("", CreateChatByPatientResponse.fromJson(response.data));
      } else {
        return ("Return other error code service", null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response!.statusCode == 500) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      } else {
        return ('Api call Error in Booking service', null);
      }
    }
  }

//get messege inside the chat
  Future<(String, List<ChatMessage>?)> getAllMesssages(
      {required chatRoomId}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final Response response =
          await Dio().get('${ApiEndPoints.getAllMessages}/$chatRoomId',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      if (response.statusCode == 200) {
        List<ChatMessage>? messageLists;
        try {
          messageLists = ChatMessage.parseChatMessages(response.data);
        } catch (e) {
          log('error parsing message list , but 200 is status code');
        }

        return ("", messageLists);
      } else {
        return ("Return other error code service", null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response?.statusCode == 500) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      } else {
        return ('Api call Error in Booking service', null);
      }
    }
  }

  Future<(String, NewChatResponse?)> sendNewMessage(
      {required String message,
      required String role,
      required String chatRoomID}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final Response response =
          await Dio().post('${ApiEndPoints.getAllMessages}/$chatRoomID',
              data: jsonEncode({"content": message, "role": role}),
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ("", NewChatResponse.fromJson(response.data));
      } else {
        return ("Return other error code service", null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response!.statusCode == 500) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      } else {
        return ('Api call Error in Booking service', null);
      }
    }
  }
}
