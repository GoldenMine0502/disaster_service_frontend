

import 'package:flutter/material.dart';

const mainTextStyle = TextStyle(
    fontSize: 25,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold
);

const menuTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'Pretendard',
);

class DisasterGuideScreen extends StatelessWidget {
  const DisasterGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "➋  재난시 대처법",
              style: mainTextStyle,
            ),
            Icon(Icons.search),
          ],
        ),
      ),
      body: ListView(
        children: [
          _buildListTile("화재 상황 재난 대처법"),
          _buildDivider(),
          _buildListTile("지진 상황 재난 대처법"),
          _buildDivider(),
          _buildListTile("홍수 상황 재난 대처법"),
          _buildDivider(),
          _buildListTile("산사태 상황 재난 대처법"),
        ],
      ),
    );
  }

  Widget _buildListTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: menuTextStyle,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // 원하는 동작 추가
      },
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 1,
      height: 1,
      color: Colors.grey[300],
    );
  }
}