import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class Vocabulary {
  final String english;
  final String mean;

  Vocabulary({required this.english, required this.mean});

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      english: json['english'],
      mean: json['mean'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('JSON 파일 생성 예제')),
        body: Center(
          child: MyButton(),
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  // JSON 파일 저장 함수
  Future<void> saveJsonFile(String fileName, Map<String, dynamic> data) async {
      final directory = await getApplicationDocumentsDirectory(); // 앱 문서 디렉토리 경로 가져오기
      //print("문서 디렉토리 경로: ${directory.path}");
      final file = File('${directory.path}/$fileName.json'); // 파일 객체 생성

      Map<String, dynamic> jsonData = {
        "{$fileName}": [

        ]
      };
      String jsonString = jsonEncode(jsonData);
      await file.writeAsString(jsonString);
      String jsonString2 = file.readAsStringSync();
      print(jsonString2);
      // final jsonData = jsonEncode(data); // Map을 JSON 문자열로 변환
      // await file.writeAsString(jsonData); // 파일에 JSON 문자열 쓰기

  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 버튼 클릭 시 실행될 로직
        Map<String, dynamic> data = {
          'name': 'Flutter',
          // 추가 데이터 필드
        };
        saveJsonFile('${DateTime.now().millisecondsSinceEpoch}', data);
      },
      child: Text('JSON 파일 생성'),
    );
  }
}
