
import '../api.dart';

class ImageDataDTO {
  final int id;
  final DateTime timestamp;
  final String token;
  final int label;
  final double percent;

  ImageDataDTO({
    required this.id,
    required this.timestamp,
    required this.token,
    required this.label,
    required this.percent,
  });

  String getImageUri() {
    return '$domain/images/image/$id';
  }

  // Factory method to create an instance from a JSON object
  factory ImageDataDTO.fromJson(Map<String, dynamic> json) {
    return ImageDataDTO(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      token: json['token'],
      label: json['label'],
      percent: json['percent'],
    );
  }

  // Method to convert an instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'token': token,
      'label': label,
      'percent': percent,
    };
  }
}

class ResponseRecentImages {
  List<ImageDataDTO> list;

  ResponseRecentImages({
    required this.list,
  });

  factory ResponseRecentImages.fromJson(Map<String, dynamic> json) {
    return ResponseRecentImages(
        list: List<ImageDataDTO>.from(json["list"].map((model) => ImageDataDTO.fromJson(model))).toList()
    );
  }
}