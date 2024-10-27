import 'dart:convert'; // JSON 변환용
import 'dart:io'; // 파일 다루기용
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP 요청용
import 'package:path/path.dart' as path;

import 'api.dart';
import 'dto/dto_upload.dart';

Future<ResponseDisasterDetection> uploadImage(File image) async {
  final request = await http.MultipartRequest(
    'POST',
    Uri.parse('$domain/images/check'),
  )
    ..headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    })
    ..files.add(await http.MultipartFile.fromPath('image', image.path,
        filename: path.basename(image.path)));

  try {
    var response = await request.send();
    var responseData = await http.Response.fromStream(response);

    if (response.statusCode != 200) {
      throw Exception('error: ${response.statusCode}, ${responseData.body}');
    }

    debugPrint(responseData.body);
    debugPrint(responseData.statusCode.toString());

    return ResponseDisasterDetection.fromJson(
        json.decode(utf8.decode(responseData.bodyBytes)) as Map<String, dynamic>
    );
  } catch (e, stackTrace) {
    throw Exception('error: $e $stackTrace');
  }
}
