import 'dart:async';

import 'package:flutter/material.dart';

import 'api/api_status.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel(); // 기존 타이머가 있으면 취소
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (mounted) {
        setState(() {
        });
      }
    });
  }

  Future<bool> fetchCurrentStatus() async {
    var res = await fetchRecentImages();

    var dto = res.list.where((li) => checkIfWithinOneDay(li.timestamp)).firstOrNull;

    if(dto != null) {
      image = Image.network(dto.getImageUri());
    }

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
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // 상단 여백
            const Text(
              "아무튼 좋은 말\n아무튼 안부인사 같은 말",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard',
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
                              const Text("충청북도 충주시", style: textStyleInBox),
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
                                "       내 위치에서 30KM",
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "비상 연락처",
                              style: textStyleInBoxTiltDisaster,
                            ),
                            Text(
                              "대피소",
                              style: textStyleInBoxTiltDisaster,
                            ),
                            Text(
                              "실시간 공유",
                              style: textStyleInBoxTiltDisaster,
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
    return FutureBuilder<bool>(
      future: fetchCurrentStatus(), // Future 함수 호출
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Future가 아직 완료되지 않은 경우 로딩 인디케이터 표시
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Future 실행 중 에러 발생 시 에러 메시지 표시
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          // Future가 완료되고 데이터가 있는 경우 true 또는 false에 따라 다른 UI 표시
          if (snapshot.data == true) {
            return disaster(context);
          } else {
            return normal(context);
          }
        } else {
          // 데이터가 없을 때 (예외 상황)
          return const Text("No data available.");
        }
      },
    );
  }
}
