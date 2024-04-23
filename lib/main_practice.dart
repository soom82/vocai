import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Button Addition'),
        ),
        body: DynamicButtonAddition(),
      ),
    );
  }
}

class DynamicButtonAddition extends StatefulWidget {
  @override
  _DynamicButtonAdditionState createState() => _DynamicButtonAdditionState();
}

class _DynamicButtonAdditionState extends State<DynamicButtonAddition> {
  List<Widget> buttonsList = [];

  void addButton() {
    Widget newButton =  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150,100),
          backgroundColor: Colors.white,
          // 글자 색상 및 애니메이션 색 설정
          foregroundColor: Colors.black,
          // 글자 그림자 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          // 글자 3D 입체감 높이
          textStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30.0,
          ),
          //padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
        ),
        child: Text('List ${buttonsList.length + 1}'),
      )
    );
    Widget space = SizedBox(height: 10); // 원하는 높이로 조절
    setState(() {
      buttonsList.add(space);
      buttonsList.add(newButton);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: buttonsList.length,
            itemBuilder: (context, index) {
              return buttonsList[index];
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ElevatedButton(
            onPressed: () {
              addButton();
            },
            child: Text('Add Button'),
          ),
        )
      ],
    );
  }
}
