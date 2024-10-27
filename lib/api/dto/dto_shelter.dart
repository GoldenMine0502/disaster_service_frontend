

class Shelter {
  final int id;
  final String name;
  final String type;
  final String address;
  final double latitude;
  final double longitude;
  final double area;
  final int capacity;
  final String? isOpen;
  final String? usageType;
  final String? contactNumber;
  final String? managingAgency;

  Shelter({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.area,
    required this.capacity,
    this.isOpen,
    this.usageType,
    this.contactNumber,
    this.managingAgency,
  });

  // JSON으로부터 Shelter 객체 생성
  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      area: json['area'],
      capacity: json['capacity'],
      isOpen: json['isOpen'],
      usageType: json['usageType'],
      contactNumber: json['contactNumber'],
      managingAgency: json['managingAgency'],
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'area': area,
      'capacity': capacity,
      'isOpen': isOpen,
      'usageType': usageType,
      'contactNumber': contactNumber,
      'managingAgency': managingAgency,
    };
  }
}

class ResponseShelterList {
  final List<Shelter> list;

  ResponseShelterList({required this.list});

  // JSON으로부터 ShelterListResponse 객체 생성
  factory ResponseShelterList.fromJson(Map<String, dynamic> json) {
    return ResponseShelterList(
      list: (json['list'] as List).map((item) => Shelter.fromJson(item)).toList(),
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'list': list.map((shelter) => shelter.toJson()).toList(),
    };
  }
}