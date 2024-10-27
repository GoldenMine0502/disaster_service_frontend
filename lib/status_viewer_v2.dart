import 'package:flutter/material.dart';

class StatusViewerScreen extends StatefulWidget {
  const StatusViewerScreen({super.key});

  @override
  StatusViewerScreenState createState() => StatusViewerScreenState();
}

const selectBarTextStyle = TextStyle(
    fontSize: 20, fontFamily: 'Pretendard', fontWeight: FontWeight.bold);

const textStyleInBox = TextStyle(
  fontSize: 26,
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const textStyleInBoxTilt = TextStyle(
  fontSize: 26,
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.bold,
  color: Color(0xFF17A1AE),
);

const textStyleInBoxTiltDisaster = TextStyle(
  fontSize: 18,
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.bold,
  color: Color(0xFF17A1AE),
);

const mainPadding = EdgeInsets.only(left: 25 + 6, right: 25);

class StatusViewerScreenState extends State<StatusViewerScreen> {
  bool isDisaster = false;

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
                fontSize: 28,
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
                      width: 70,
                      height: 4,
                      color: const Color(0xFF6F448C),
                    ),
                    const SizedBox(width: 22),
                    Container(
                      width: 70,
                      height: 4,
                      color: const Color(0xFFCCCCCC),
                    ),
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
                        // 사용자 이미지를 넣으려면 backgroundImage 속성을 사용하세요
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
                        const Text("재난 위험도 : 현저히 낮음",
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
                        margin: const EdgeInsets.only(right: 16),
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

/*
Column(
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "내 위치에서 30KM",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Stack(
                  children: [
                    Center(
                      child: Text(
                        "맵 또는 정보 표시 영역",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Icon(Icons.open_in_full, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "비상 연락처",
                      style: TextStyle(
                        color: Color(0xFF17A1AE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "대피소",
                      style: TextStyle(
                        color: Color(0xFF17A1AE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "실시간 공유",
                      style: TextStyle(
                        color: Color(0xFF17A1AE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
 */

  @override
  Widget build(BuildContext context) {
    if (isDisaster) {
      return disaster(context);
    } else {
      return normal(context);
    }
  }
}
