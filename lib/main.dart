
import 'package:disaster_service_frontend/status_viewer.dart';
import 'package:flutter/material.dart';

import 'image_upload.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Drawer with Body Change',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() { return HomePageState(); }

}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;  // 현재 선택된 화면의 인덱스

  // 각 탭에 보여줄 화면 위젯 리스트
  final List<Widget> _pages = [
    const StatusViewerScreen(),
    const ImageUploadScreen(),
  ];

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // 인덱스를 변경하여 body 교체
    });
    Navigator.pop(context);  // 드로어 메뉴 닫기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Status Viewer'),
              onTap: () => _onDrawerItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Image Upload'),
              onTap: () => _onDrawerItemTapped(1),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],  // 현재 선택된 인덱스에 따라 body 교체
    );
  }
}