import 'dart:async';

import 'package:disaster_service_frontend/api/dto/dto_weather.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'api/api_status.dart';
import 'api/api_weather.dart';
import 'chat.dart';

class StatusViewerScreen extends StatefulWidget {
  const StatusViewerScreen({super.key});

  @override
  StatusViewerScreenState createState() => StatusViewerScreenState();
}

const selectBarTextStyle = TextStyle(
    fontSize: 18, fontFamily: 'Pretendard', fontWeight: FontWeight.bold);

const textStyleInBox = TextStyle(
  fontSize: 22,
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const textStyleInBoxTilt = TextStyle(
  fontSize: 22,
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.bold,
  color: Color(0xFF17A1AE),
);

const textStyleInBoxTiltDisaster = TextStyle(
  fontSize: 16,
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.bold,
  color: Color(0xFF17A1AE),
);

const mainPadding = EdgeInsets.only(left: 25, right: 25);

class StatusViewerScreenState extends State<StatusViewerScreen> with WidgetsBindingObserver {
  bool isDisaster = false;
  Image? image;
  Timer? _timer;
  ResponseCurrentWeather? locationResult;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
    requestLocationPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      // Request location permission
      status = await Permission.location.request();
    }

    // if (status.isPermanentlyDenied) {
    //   // Open app settings to manually enable permission
    //   await openAppSettings();
    // }

    if (status.isGranted) {
      debugPrint("Location permission granted.");
      // Proceed with accessing location
    } else if (status.isDenied) {
      debugPrint("Location permission denied.");
      // Handle the permission denial accordingly
    }
  }

  void startTimer() {
    _timer?.cancel(); // 기존 타이머가 있으면 취소
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (mounted) {
        var status = await Permission.location.status;

        fetchCurrentStatus();

        if(status.isGranted) {
          var position = await _determinePosition();
          debugPrint("${position.latitude}, ${position.longitude}");
          var response = await getCurrentTemperature(
              RequestCurrentWeather(
                  latitude: position.latitude,
                  longitude: position.longitude
              )
          );
          debugPrint("locationResult: ${locationResult?.locationData.getLevelKey()}");

          locationResult = response;
          setState(() { });
        }
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, prompt the user to enable them
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> fetchCurrentStatus() async {
    var res = await fetchRecentImages();

    var dto = res.list.where((li) => checkIfWithinOneDay(li.timestamp)).firstOrNull;

    if(dto != null) {
      debugPrint(dto.getImageUri());
      image = Image.network(dto.getImageUri());
    }

    isDisaster = dto != null;

    setState(() {

    });

    return dto != null;
  }

  bool checkIfWithinOneDay(DateTime currentTime) {
    DateTime time = DateTime.now();
    // 현재 시간에서 특정 시간의 차이를 계산
    Duration difference = time.difference(currentTime);

    // 차이가 하루(24시간) 이내인지 확인, 테스트용으론 5분으로 처리
    return difference.inMinutes <= 5;
    // return difference.inHours <= 24;
  }

  Widget normal(BuildContext context) {
    var location = locationResult?.locationData.getLevelKey(containLevel1: false) ?? "충청북도";
    if(location.isEmpty) {
      location = "충청북도";
    }
    var temperature = locationResult?.temperature?.toInt() ?? 25;

    var totalText = "$location $temperature'C";

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // 상단 여백
            const Text(
              "함께라면 어떤 재난도\n이겨낼 수 있어요!",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'SBAggro',
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Row(
                  children: [
                    Padding(
                        padding: mainPadding,
                        child: Text("현재",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.bold))),
                    SizedBox(height: 10),
                    Padding(
                        padding: mainPadding,
                        child: Text("과거",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFCCCCCC),
                            ))),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    Container(
                      width: 68,
                      height: 4,
                      color: const Color(0xFF6F448C),
                    ),
                    // const SizedBox(width: 22),
                    // Container(
                    //   width: 70,
                    //   height: 4,
                    //   color: const Color(0xFFCCCCCC),
                    // ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/icon/location.png',
                                  width: 16),
                              const SizedBox(width: 12),
                              Text(totalText, style: textStyleInBox),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text("재난 위험 : 없음",
                            style: textStyleInBoxTilt),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/icon/disaster1.png",
                                width: 40, height: 40),
                            Image.asset("assets/icon/disaster2.png",
                                width: 40, height: 40),
                            Image.asset("assets/icon/disaster3.png",
                                width: 40, height: 40),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget disaster(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                Container(
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF17A1AE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/icon/sos.png", width: 80),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.white),
                                  SizedBox(width: 4),
                                  Text(
                                    "충청북도 충주시",
                                    style: textStyleInBox,
                                  ),
                                ],
                              ),
                              Text(
                                "       내 위치에서 1KM",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pretendard'
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.only(left: 24),
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10.0), // 내부 여백 설정
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF17A1AE), // 내부 박스 색상
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: image != null ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                        child: image
                                    ) : const CircularProgressIndicator(),
                                  ),
                                  // const Align(
                                  //   alignment: Alignment.bottomRight,
                                  //   child: Padding(
                                  //     padding: EdgeInsets.all(8.0),
                                  //     child: Icon(
                                  //       Icons.open_in_full,
                                  //       color: Colors.white,
                                  //       size: 20,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            // Positioned(
                            //   bottom: 8,
                            //   right: 8,
                            //   child: Icon(Icons.open_in_full, color: Colors.grey),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.only(right: 24),
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "비상 연락처",
                              style: textStyleInBoxTiltDisaster,
                            ),
                            const Text(
                              "대피소",
                              style: textStyleInBoxTiltDisaster,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChatScreen()),
                                  );
                                },
                                child: const Text(
                                  "실시간 채팅",
                                  style: textStyleInBoxTiltDisaster,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("disaster: $isDisaster");
    if (isDisaster) {
      return disaster(context);
    } else {
      return normal(context);
    }
  }
}
