

class RequestCurrentWeather {
  final double latitude;
  final double longitude;

  RequestCurrentWeather({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  factory RequestCurrentWeather.fromJson(Map<String, dynamic> json) {
    return RequestCurrentWeather(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class ResponseCurrentWeather {
  final LocationData locationData;
  final double? temperature;

  ResponseCurrentWeather({
    required this.locationData,
    required this.temperature,
  });

  Map<String, dynamic> toJson() => {
    'locationData': locationData.toJson(),
    'temperature': temperature,
  };

  factory ResponseCurrentWeather.fromJson(Map<String, dynamic> json) {
    return ResponseCurrentWeather(
      locationData: LocationData.fromJson(json['locationData']),
      temperature: json['temperature'],
    );
  }
}

class LocationData {
  final String country;
  final String adminCode;
  final String? level1;
  final String? level2;
  final String? level3;
  final int gridX;
  final int gridY;
  final int longitudeDegree;
  final int longitudeMinute;
  final double longitudeSecond;
  final int latitudeDegree;
  final int latitudeMinute;
  final double latitudeSecond;
  final double longitudeSecPer100;
  final double latitudeSecPer100;
  final String? locationUpdate;

  LocationData({
    required this.country,
    required this.adminCode,
    this.level1,
    this.level2,
    this.level3,
    required this.gridX,
    required this.gridY,
    required this.longitudeDegree,
    required this.longitudeMinute,
    required this.longitudeSecond,
    required this.latitudeDegree,
    required this.latitudeMinute,
    required this.latitudeSecond,
    required this.longitudeSecPer100,
    required this.latitudeSecPer100,
    this.locationUpdate,
  });

  String getLevelKey({bool containLevel1=true}) {
    if (level1 == null) return "";

    final StringBuffer builder = StringBuffer();

    if(containLevel1) {
      builder.write(level1);
    }

    if (level2 != null) {
      if(containLevel1) {
        builder.write(" ");
      }
      builder.write(level2);
    }
    if (level3 != null) {
      builder.write(" ");
      builder.write(level3);
    }

    return builder.toString();
  }

  Map<String, dynamic> toJson() => {
    'country': country,
    'adminCode': adminCode,
    'level1': level1,
    'level2': level2,
    'level3': level3,
    'gridX': gridX,
    'gridY': gridY,
    'longitudeDegree': longitudeDegree,
    'longitudeMinute': longitudeMinute,
    'longitudeSecond': longitudeSecond,
    'latitudeDegree': latitudeDegree,
    'latitudeMinute': latitudeMinute,
    'latitudeSecond': latitudeSecond,
    'longitudeSecPer100': longitudeSecPer100,
    'latitudeSecPer100': latitudeSecPer100,
    'locationUpdate': locationUpdate,
  };

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      country: json['country'],
      adminCode: json['adminCode'],
      level1: json['level1'],
      level2: json['level2'],
      level3: json['level3'],
      gridX: json['gridX'],
      gridY: json['gridY'],
      longitudeDegree: json['longitudeDegree'],
      longitudeMinute: json['longitudeMinute'],
      longitudeSecond: json['longitudeSecond'],
      latitudeDegree: json['latitudeDegree'],
      latitudeMinute: json['latitudeMinute'],
      latitudeSecond: json['latitudeSecond'],
      longitudeSecPer100: json['longitudeSecPer100'],
      latitudeSecPer100: json['latitudeSecPer100'],
      locationUpdate: json['locationUpdate'],
    );
  }
}