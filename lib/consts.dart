import 'package:flutter/material.dart';

const labels = [
  'collapsed_building',
  'fire',
  'flooded_areas',
  'normal',
  'traffic_incident'
];

var logoBig = Image.asset(
  'assets/logo/logo_big.png', // 중앙에 배치할 SVG 파일 경로
  width: 226,
  height: 150,
);

var logoSmall = Image.asset(
  'assets/logo/logo_small.png', // 아래에 위치할 SVG 파일 경로
  width: 75,
  height: 50
);