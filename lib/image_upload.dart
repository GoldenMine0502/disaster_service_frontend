
import 'dart:io'; // 파일 다루기용
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 이미지 선택용 패키지
import 'package:permission_handler/permission_handler.dart';

import 'api/api_upload.dart';
import 'consts.dart';


class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  ImageUploadScreenState createState() => ImageUploadScreenState();
}

class ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image; // 선택한 이미지 파일
  final picker = ImagePicker(); // 이미지 선택기
  String _resultText = ''; // 서버로부터 받은 결과 텍스트

  @override
  void initState() {
    super.initState();
  }

  // 권한 확인 및 요청
  Future<void> requestStoragePermission() async {
    PermissionStatus result = await Permission.storage.request();

    if (result.isGranted) {
      debugPrint("권한이 허용되었습니다!");
    } else if (result.isDenied) {
      // 권한이 거부된 경우 사용자에게 권한 요청 이유 설명
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text("권한이 필요합니다."),
              content: const Text("이 기능을 사용하려면 저장소 권한이 필요합니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("닫기"),
                ),
                TextButton(
                  onPressed: () {
                    openAppSettings(); // 앱 설정 화면으로 이동
                  },
                  child: const Text("설정으로 가기"),
                ),
              ],
            ),
      );
    } else if (result.isPermanentlyDenied) {
      print("권한이 영구적으로 거부되었습니다.");
      openAppSettings(); // 앱 설정 화면으로 이동하여 사용자가 권한을 수동으로 활성화하도록 유도
    }
  }

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  // 이미지 업로드 함수
  Future<void> _uploadImage() async {
    if (_image == null) return;

    var result = await uploadImage(_image!);

    setState(() {
      _resultText = '${labels[result.label]}, ${result.labelPercent()} %';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Image Upload Example'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(
              _image!,
              height: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            Text(_resultText),
          ],
        ),
      ),
    );
  }
}