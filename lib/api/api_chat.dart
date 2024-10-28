
import 'dart:convert'; // JSON 변환용
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP 요청용
import 'api.dart';
import 'dto/dto_chat.dart';

Future<ResponseChatList> fetchChatList() async {
  final response = await http.get(Uri.parse('$domain/chat/list'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load shelters ${response.statusCode} ${response.body}');
  }

  return ResponseChatList.fromJson(
      json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>
  );
}

Future<void> sendChat(RequestSendChat request) async {
  debugPrint('text: ${request.text}');
  final uri = Uri.parse('$domain/chat/send');
  final response = await http.put(
    uri,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to send chat message: ${response.statusCode} ${response.body}');
  }

  // Handle response if necessary
  debugPrint("Message sent successfully!");
}