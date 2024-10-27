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

class EmergencyContactScreen extends StatelessWidget {
  const EmergencyContactScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "➍  비상 연락처",
              style: mainTextStyle,
            ),
            Icon(Icons.search),
          ],
        ),
      ),
      body: ListView(
        children: [
          _buildListTile("내 비상 연락망"),
          _buildDivider(),
          _buildListTile("소방서"),
          _buildDivider(),
          _buildListTile("병원"),
          _buildDivider(),
          _buildListTile("경찰청"),
          _buildDivider(),
          _buildListTile("대피소"),
          _buildDivider(),
          _buildListTile("국가 기관"),
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
