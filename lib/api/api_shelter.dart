import 'dart:convert'; // JSON 변환용
import 'dart:io'; // 파일 다루기용
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP 요청용
import 'package:path/path.dart' as path;

import 'api.dart';
import 'dto/dto_shelter.dart';


Future<ResponseShelterList> fetchShelterList() async {
  final response = await http.get(Uri.parse('$domain/shelter/list'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load shelters ${response.statusCode} ${response.body}');
  }

  return ResponseShelterList.fromJson(
      json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>
  );
}