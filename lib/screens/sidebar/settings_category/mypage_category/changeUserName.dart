import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;

class ChangeUserId extends StatefulWidget {
  const ChangeUserId({Key? key}) : super(key: key);

  @override
  State<ChangeUserId> createState() => _ChangeUserIdState();
}

class _ChangeUserIdState extends State<ChangeUserId> {
  String newUsername = '';
  final TextEditingController _textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          title: Text('닉네임 변경', style: TextStyle(color: Colors.black)),

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
                      hintText: '변경할 닉네임을 입력하세요.',
                    ),
                    controller: _textController,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    // newUsername = _textController.text;
                    // _textController.text = '';
                    // print(globals.currentUid);
                    // print(newUsername);
                    // FirebaseFirestore.instance
                    //     .collection('user')
                    //     .doc(globals.currentUid)
                    //     .set({
                    //   'email': globals.currentEmail,
                    //   'statusKey': globals.statusKey,
                    //   'userName': newUsername,
                    //   'userUID': globals.currentUid,
                    // });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("사용자 정보 변경은 준비중인 기능입니다."),
                    ));
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
