import 'package:flutter/material.dart';
import 'package:RouF/screens/sidebar/settings_category/faq_board.dart';
import 'package:RouF/screens/sidebar/settings_category/notice_board.dart';

class RoufSettings extends StatefulWidget {
  const RoufSettings({Key? key}) : super(key: key);

  @override
  State<RoufSettings> createState() => _RoufSettingsState();
}

class _RoufSettingsState extends State<RoufSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          title: Text('설정', style: TextStyle(color: Colors.black)),

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
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          ListTile(
            // minVerticalPadding: -10.0,
            visualDensity: VisualDensity(vertical: -3.0),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            horizontalTitleGap: 5.0,
            leading: Icon(
              Icons.account_circle_rounded,
              color: Colors.black,
            ),
            title: Text('내 정보',
                style: TextStyle(
                  fontFamily: 'Mono',
                  fontWeight: FontWeight.w400,
                )),
            onTap: () {
              print("내 정보 is clicked");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) {
              //     return FriendRequest();
              //   }),
              // );
            },
          ),
          Divider(),
          ListTile(
            visualDensity: VisualDensity(vertical: -3.0),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            horizontalTitleGap: 5.0,
            leading: Icon(
              Icons.sticky_note_2_outlined,
              color: Colors.black,
            ),
            title: Text('공지사항',
                style: TextStyle(
                  fontFamily: 'Mono',
                  fontWeight: FontWeight.w400,
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NoticeBoard();
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            // minVerticalPadding: -10.0,
            visualDensity: VisualDensity(vertical: -3.0),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            horizontalTitleGap: 5.0,
            leading: Icon(
              Icons.question_mark_rounded,
              color: Colors.black,
            ),
            title: Text('FAQ',
                style: TextStyle(
                  fontFamily: 'Mono',
                  fontWeight: FontWeight.w400,
                )),
            onTap: () {
              print("FAQ is clicked");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return FaqBoard();
                }),
              );
            },
          ),
          Divider(),
        ]),
      ),
    );
  }
}
