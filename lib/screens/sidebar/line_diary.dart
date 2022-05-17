import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:RouF/globals.dart' as globals;
import 'package:flutter/material.dart';

class LineDiary extends StatefulWidget {
  const LineDiary({Key? key}) : super(key: key);

  @override
  State<LineDiary> createState() => _LineDiaryState();
}

class _LineDiaryState extends State<LineDiary> {
  String diaryContent = '';
  final TextEditingController _textController = new TextEditingController();
  DateTime todayDate = DateTime.now();

  String makeDate() {
    String date = '';
    date = todayDate.toString().substring(2, 4) +
        todayDate.toString().substring(5, 7) +
        todayDate.toString().substring(8, 10);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    final maxLines = 8;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          title: Text('한 줄 일기', style: TextStyle(color: Colors.black)),

          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),

          iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
          elevation: 0.0,

          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 3,
              ),
              Container(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: maxLines * 25.0,
                    child: TextField(
                      maxLines: maxLines,
                      maxLength: 150,
                      controller: _textController,
                      //onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '글자수는 150자 미만으로 적어주세요',
                      ),
                    ),
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  diaryContent = _textController.text;
                  //_textController.text = '';
                  print(globals.currentUid);
                  print(diaryContent);
                  FirebaseFirestore.instance
                      .collection(
                          'user/${globals.currentUid}/data/${makeDate()}/diary')
                      .doc('diary')
                      .set({
                    'content': diaryContent,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("오늘의 일기가 작성되었습니다."),
                  ));
                },
                child: Text('작성하기/다시쓰기'),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _handleSubmitted() async {
  //   // setState(() {
  //   //   diaryContent = text;
  //   // });
  //   diaryContent = _textController.text;
  //   print(globals.currentUid);
  //   print(diaryContent);
  //   FirebaseFirestore.instance
  //       .collection('user/${globals.currentUid}/data/${makeDate()}/diary')
  //       .doc('diary')
  //       .set({
  //     'content': diaryContent,
  //   });
  // }
}
