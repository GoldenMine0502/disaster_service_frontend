import 'package:disaster_service_frontend/disaster_shelter.dart';
import 'package:flutter/material.dart';

import 'consts.dart';
import 'main.dart';


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
            const SizedBox(height: 10), // 이미지와 텍스트 사이 간격 조정
            const Text(
              "충리미와 재난 대처해요!",
              style: TextStyle(fontSize: 16),
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
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}