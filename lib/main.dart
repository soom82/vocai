import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputDemo(),
    );
  }
}

class InputDemo extends StatefulWidget {
  @override
  _InputDemoState createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  final voca_nameController = TextEditingController();
  List<String> vocalistname = [];

  @override
  void dispose() {
    voca_nameController.dispose();

    super.dispose();
  }

  List<Widget> buttonsList = [];

  void addButton(String input_text) {
    Widget newButton = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: Size(150, 100),
            backgroundColor: Colors.white,
            // 글자 색상 및 애니메이션 색 설정
            foregroundColor: Colors.black,
            // 글자 그림자 설정
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            // 글자 3D 입체감 높이
            textStyle: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30.0,
            ),
            //padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
          ),
          child: Text(input_text),
        ));
    Widget space = SizedBox(height: 10); // 원하는 높이로 조절
    setState(() {
      buttonsList.add(space);
      buttonsList.add(newButton);
    });

  }
  Future<void> saveJsonFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory(); // 앱 문서 디렉토리 경로 가져오기
    //print("문서 디렉토리 경로: ${directory.path}");
    final file = File('${directory.path}/$fileName.json'); // 파일 객체 생성
    vocalistname.add('$fileName.json');
    print(vocalistname);
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
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          'voca list',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w200,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/logo.png', // 로고 이미지의 경로
              width: 70, // 로고 이미지의 폭 조정
              height: 70, // 로고 이미지의 높이 조정
            ),
          ),
        ],
        backgroundColor: Color(0xffEEEBEB),
      ),
      body: Container(
        width: double.infinity,
        // 가로 꽉차게 설정
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEEEBEB),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '자신만의 단어장을 \n 만들어보세요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffB6B1B1),
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              height: 400,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: buttonsList.length,
                      itemBuilder: (context, index) {
                        return buttonsList[index];
                      },
                    )

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(30, 65), // 버튼의 최소 가로, 세로 크기 설정
                  backgroundColor: Colors.white
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context)
                  {
                    // TextEditingController를 사용하여 TextField의 입력값 관리
                    TextEditingController customController = TextEditingController();
                    return AlertDialog(
                      title: Text('단어장 이름 정하기'),
                      content: TextField(
                        controller: customController,
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('확인'),
                          onPressed: () {
                            addButton(customController.text);
                            saveJsonFile(customController.text);
                            // 여기서 customController.text를 사용하여 입력값 처리
                            Navigator.of(context).pop(); // 다이얼로그 닫기
                          },
                        ),
                      ],
                    );
                  }
                  );
                },
                child: Text('+',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                ),),
              ),
            )

          ],
        ), // child: Text('안녕하세요', style: TextStyle( color : Colors.red )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green, // 선택된 요소 색
        unselectedItemColor: Colors.grey, // 선택되지 않은 요소 색
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'upload'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'vocabulary'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'menu'),
        ],
      ),
    ));
  }
}
