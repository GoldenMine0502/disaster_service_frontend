import 'package:flutter/material.dart';

import 'api/api_status.dart';
import 'api/dto/recent_image.dart';
import 'consts.dart';

class StatusViewerScreen extends StatefulWidget {
  const StatusViewerScreen({super.key});

  @override
  StatusViewerScreenState createState() => StatusViewerScreenState();
}

class StatusViewerScreenState extends State<StatusViewerScreen> {
  Widget _futureBuilder(BuildContext context) {
    return FutureBuilder(
      future: fetchRecentImages(), // 비동기적으로 게시글 로드
      builder:
          (BuildContext context, AsyncSnapshot<ResponseRecentImages> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩 중일 때 로딩 인디케이터 표시
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // 데이터가 성공적으로 로드되면 UI 구성
          List<ImageDataDTO> images = snapshot.data!.list;

          return ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              final image = images[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(data: image),
                    ),
                  );
                },
                leading: Image.network(image.getImageUri()),
                title: Text('${labels[image.label]}, ${image.percent}%'),
                subtitle: Text('${image.id}, ${image.token}',),
              );
            },
          );
        } else {
          debugPrint(snapshot.error.toString());
          debugPrint(snapshot.stackTrace.toString());
          // 데이터 로드 실패 시
          return const Center(child: Text('데이터를 불러올 수 없습니다.'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('ListView with Image & Text'),
        // ),
        body: _futureBuilder(context));
  }
}

class DetailScreen extends StatelessWidget {
  final ImageDataDTO data;

  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 추가: 크게 화면에 표시
            Image.network(
              data.getImageUri(), // 이미지 URL
              width: double.infinity, // 가로로 화면 전체 사용
              height: 300, // 원하는 높이 설정
              fit: BoxFit.cover, // 이미지를 화면에 꽉 채움
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${labels[data.label]}, ${data.percent} %',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Token: ${data.token}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
