import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'api/api_shelter.dart';

class DisasterShelterScreen extends StatelessWidget {
  const DisasterShelterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: const NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(36.8023, 127.7238), // 충북 위도 경도
          zoom: 10,
          bearing: 0,
          tilt: 0
      ),),
      onMapReady: (controller) async {
        debugPrint("네이버 맵 로딩됨!");

        var shelterList = await fetchShelterList();

        for(var i = 0; i < shelterList.list.length; i++) {
          final shelter = shelterList.list[i];

          final marker = NMarker(id: '$i', position: NLatLng(shelter.latitude, shelter.longitude));
          controller.addOverlay(marker);
        }
      },
    );
  }
}

Future<void> initializeNaverMap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
    clientId: 'itbjcixv9o',
    onAuthFailed: (e) => debugPrint('네이버 맵 인증 오류: $e')
  );
}