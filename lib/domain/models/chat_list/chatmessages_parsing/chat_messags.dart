class ChatMessage {
  String messageId;
  String conversationId;
  String senderModel;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  ChatMessage({
    required this.messageId,
    required this.conversationId,
    required this.senderModel,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['_id'],
      conversationId: json['conversation']['_id'],
      senderModel: json['senderModel'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  static List<ChatMessage> parseChatMessages(List<dynamic> jsonList) {
    return jsonList.map((json) => ChatMessage.fromJson(json)).toList();
  }
}
