import 'dart:convert'; // JSON 변환용
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP 요청용
import 'api.dart';
import 'dto/recent_image.dart';

Future<ResponseRecentImages> fetchRecentImages() async {
  final response = await http.get(Uri.parse('$domain/images/recent'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load recent images ${response.statusCode} ${response.body}');
  }

  return ResponseRecentImages.fromJson(
      json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>
  );
}