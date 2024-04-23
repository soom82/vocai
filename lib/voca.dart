import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

// 앱 구동
void main() {
  runApp( MaterialApp(
    home: JsonScreen(),
  ));
  // MyApp() 자리 -> 앱 메인 페이지 입력
}
class Word {
  final String example;
  final List<Vocabulary> vocabulary;

  Word({required this.example, required this.vocabulary});

  Map<String, dynamic> toJson() {
    return {
      'example': example,
      'vocabulary': vocabulary,
    };
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    List<dynamic> vocabulariesJson = json['vocabulary'];
    List<Vocabulary> vocabularies = vocabulariesJson.map((data) => Vocabulary.fromJson(data)).toList();

    return Word(
      example: json['example'],
      vocabulary: vocabularies,
    );
  }
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

class JsonScreen extends StatefulWidget {
  @override
  _JsonScreenState createState() => _JsonScreenState();
}

class _JsonScreenState extends State<JsonScreen> {
  List<Word> words = [];

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    String jsonString = await rootBundle.loadString('lib/data.json');
    List<dynamic> jsonData = json.decode(jsonString)['words'];
    print(jsonData);
    setState(() {
      words = jsonData.map((data) => Word.fromJson(data)).toList();
      print(words);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
          appBar: PreferredSize(
            preferredSize : Size.fromHeight(60),
            child : AppBar(

              title: Text('voca list', style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w200,
              ),),
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
          ),
          body: Container(
            width: double.infinity, // 가로 꽉차게 설정
            decoration: BoxDecoration(
              color: Color(0xFFEEEBEB),
            ),
            child: Column(
                children: [
                  SizedBox(height: 20,), //아이콘 넣을 공간
                  Row(
                    children: [
                      Flexible(flex: 1, child: SizedBox(width: 30.0,),),
                      Flexible(flex: 8,
                        child: Container(
                          width: double.infinity,
                          height: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color :Colors.white),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  ListView.builder(shrinkWrap: true,
                                      itemCount: words.length,
                                      itemBuilder: (context, index){
                                        return Container(

                                          width: double.infinity,
                                          height: 80.0,
                                          margin: EdgeInsets.fromLTRB(10,10,10,0),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.blueGrey,width: 0.3),
                                              borderRadius: BorderRadius.circular(10),
                                              color :Colors.white),
                                          child: Row(
                                            children: [ Container(
                                                width: 100,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(width:0.1)
                                                    )
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded( flex: 1,
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.blueGrey,width: 0.1),
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(10)
                                                              )

                                                          ),
                                                          child: Center(child: Text(words[index].vocabulary[0].english))),),
                                                    Expanded( flex: 1,
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.blueGrey,width: 0.1),
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius.circular(10)
                                                              )

                                                          ),
                                                          child: Center(child: Text(words[index].vocabulary[0].mean))),),
                                                  ],
                                                )),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(10,10,10,10),
                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                  child: Text(words[index].example)),

                                            ],
                                          ),
                                        );

                                      }
                                  )

                                ],
                              )
                          ),
                        ),
                      )],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(40,50),
                      backgroundColor: Colors.white,
                      // 글자 색상 및 애니메이션 색 설정
                      foregroundColor: Colors.black,
                      // 글자 그림자 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // 글자 3D 입체감 높이
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30.0,
                      ),
                    ),
                    child: Text('+'),),

                ]
            ),
          ),

          bottomNavigationBar:BottomNavigationBar(

            selectedItemColor: Colors.green, // 선택된 요소 색
            unselectedItemColor: Colors.grey, // 선택되지 않은 요소 색
            items: [BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'upload'),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'vocabulary'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'menu'),],
          ),
        )

    );
  }
}
