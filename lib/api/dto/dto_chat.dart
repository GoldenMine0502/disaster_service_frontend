class RequestSendChat {
  final String text;

  RequestSendChat({required this.text});

  Map<String, dynamic> toJson() => {
    'text': text,
  };

  factory RequestSendChat.fromJson(Map<String, dynamic> json) {
    return RequestSendChat(
      text: json['text'],
    );
  }
}

class ResponseChatList {
  final List<ChatDTO> list;

  ResponseChatList({required this.list});

  Map<String, dynamic> toJson() => {
    'list': list.map((chat) => chat.toJson()).toList(),
  };

  factory ResponseChatList.fromJson(Map<String, dynamic> json) {
    return ResponseChatList(
      list: (json['list'] as List<dynamic>)
          .map((item) => ChatDTO.fromJson(item))
          .toList(),
    );
  }
}

class ChatDTO {
  final DateTime timestamp;
  final String text;
  final String ip;

  ChatDTO({
    required this.timestamp,
    required this.text,
    required this.ip,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'text': text,
    'ip': ip,
  };

  factory ChatDTO.fromJson(Map<String, dynamic> json) {
    return ChatDTO(
      timestamp: DateTime.parse(json['timestamp']),
      text: json['text'],
      ip: json['ip'],
    );
  }
}