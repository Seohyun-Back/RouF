import 'package:flutter/material.dart';

class ChangeUserId extends StatefulWidget {
  const ChangeUserId({Key? key}) : super(key: key);

  @override
  State<ChangeUserId> createState() => _ChangeUserIdState();
}

class _ChangeUserIdState extends State<ChangeUserId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          title: Text('아이디 변경', style: TextStyle(color: Colors.black)),

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
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '변경할 아이디를 입력하세요.',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    print("사용자 정보 변경은 준비중인 기능입니다.");
                    //_handleSubmitted;
                    Navigator.pop(context);
                  },
                  child: Text('확인'),
                )
              ],
            )),
      ),
    );
  }
}
