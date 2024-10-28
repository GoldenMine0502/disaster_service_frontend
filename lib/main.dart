import 'package:disaster_service_frontend/settings.dart';
import 'package:disaster_service_frontend/status_viewer_v2.dart';
import 'package:flutter/material.dart';

import 'consts.dart';
import 'disaster_guide.dart';
import 'disaster_shelter.dart';
import 'emergency_contact.dart';
import 'image_upload.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // 현재 선택된 화면의 인덱스

  // 각 탭에 보여줄 화면 위젯 리스트
  final List<Widget> _pages = [
    const StatusViewerScreen(),
    const DisasterGuideScreen(),
    const DisasterShelterScreen(),
    const EmergencyContactScreen(),
    const SettingsScreen(),
    const ImageUploadScreen(),
  ];

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 인덱스를 변경하여 body 교체
    });
    Navigator.pop(context); // 드로어 메뉴 닫기
  }

  @override
  Widget build(BuildContext context) {
    const menuTextStyle = TextStyle(
        fontSize: 22,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.bold
    );

    const menuTextStyleSmall = TextStyle(
        fontSize: 12,
        fontFamily: 'Pretendard',
    );

    return Scaffold(
      appBar: AppBar(
        title: logoSmall,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              // decoration: const BoxDecoration(
              //   color: Colors.blue,
              // ),
              child: logoBig,
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20, top: 5),
              // leading: const Icon(Icons.one),
              title: const Text('➊  재난 상태', style: menuTextStyle),
              onTap: () => _onDrawerItemTapped(0),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20, top: 10),
              // leading: const Icon(Icons.settings),
              title: const Text('➋  재난시 대처법', style: menuTextStyle),
              onTap: () => _onDrawerItemTapped(1),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20, top: 10),
              // leading: const Icon(Icons.settings),
              title: const Text('➌  재난 대피소', style: menuTextStyle),
              onTap: () => _onDrawerItemTapped(2),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20, top: 10),
              // leading: const Icon(Icons.settings),
              title: const Text('➍  비상 연락처', style: menuTextStyle),
              onTap: () => _onDrawerItemTapped(3),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20),
              // leading: const Icon(Icons.settings),
              title: const Text('설정', style: menuTextStyleSmall),
              onTap: () => _onDrawerItemTapped(4),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20),
              // leading: const Icon(Icons.settings),
              title: const Text('(이미지 업로드)', style: menuTextStyleSmall),
              onTap: () => _onDrawerItemTapped(5),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // 현재 선택된 인덱스에 따라 body 교체
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            logoBig,
            const SizedBox(height: 20), // 이미지와 텍스트 사이 간격 조정
            const Text(
              "충리미와 재난 대처해요!",
              style: TextStyle(fontSize: 20, fontFamily: 'SBAggro'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            logoSmall,
          ],
        ),
      ),
    );
  }
}

void main() async {
  await initializeNaverMap();
  debugPrint('naver map init');
  runApp(MaterialApp(
    home: SplashScreen(),
    // home: MainScreen(),
  ));
}

// flutter build ios -t lib/splash.dart
// flutter build run --release