import 'dart:convert'; // JSON 변환용
import 'dart:io'; // 파일 다루기용
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP 요청용
import 'package:path/path.dart' as path;

import 'api.dart';
import 'dto/dto_weather.dart';

Future<ResponseCurrentWeather> getCurrentTemperature(RequestCurrentWeather request) async {
  final uri = Uri.parse('$domain/weather/current');
  final response = await http.get(
    uri.replace(queryParameters: request.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load current weather: ${response.statusCode} ${response.body}');
  }

  return ResponseCurrentWeather.fromJson(
    json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
  );
}