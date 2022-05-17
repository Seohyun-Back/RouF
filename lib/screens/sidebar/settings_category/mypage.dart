import 'package:RouF/screens/sidebar/settings_category/mypage_category/changeEmail.dart';
import 'package:RouF/screens/sidebar/settings_category/mypage_category/changeUserId.dart';
import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;

import 'mypage_category/changePassword.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          title: Text('내 정보', style: TextStyle(color: Colors.black)),

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
          padding: EdgeInsets.fromLTRB(21, 10, 21, 12),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "이메일",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(globals.currentEmail,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Mono',
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  Expanded(
                    child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: <Widget>[
                          ListTile(
                            // minVerticalPadding: -10.0,
                            visualDensity: VisualDensity(vertical: -3.0),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 0.0),
                            horizontalTitleGap: 5.0,
                            title: Text('아이디',
                                style: TextStyle(
                                  fontFamily: 'Mono',
                                  fontWeight: FontWeight.w400,
                                )),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                              size: 13,
                            ),
                            onTap: () {
                              print("아이디 is clicked");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ChangeUserId();
                                }),
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                              visualDensity: VisualDensity(vertical: -3.0),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0),
                              horizontalTitleGap: 5.0,
                              title: Text('이메일',
                                  style: TextStyle(
                                    fontFamily: 'Mono',
                                    fontWeight: FontWeight.w400,
                                  )),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                                size: 13,
                              ),
                              onTap: () {
                                print("이메일 is clicked");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ChangeEmail();
                                  }),
                                );
                              }),
                          Divider(),
                          ListTile(
                            // minVerticalPadding: -10.0,
                            visualDensity: VisualDensity(vertical: -3.0),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 0.0),
                            horizontalTitleGap: 5.0,
                            title: Text('비밀번호',
                                style: TextStyle(
                                  fontFamily: 'Mono',
                                  fontWeight: FontWeight.w400,
                                )),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                              size: 13,
                            ),
                            onTap: () {
                              print("비밀번호 is clicked");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ChangePassword();
                                }),
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                              // minVerticalPadding: -10.0,
                              visualDensity: VisualDensity(vertical: -3.0),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              horizontalTitleGap: 5.0,
                              title: Text('탈퇴하기',
                                  style: TextStyle(
                                    fontFamily: 'Mono',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                  )),
                              onTap: () {
                                print("탈퇴하기 is clicked");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AlertDialog(
                                        //title: const Text(""),
                                        content: Text("계정을 삭제하시겠습니까?"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              elevation:
                                                  MaterialStateProperty.all(
                                                      0.0),
                                            ),
                                            onPressed: () {
                                              return Navigator.of(context)
                                                  .pop(false);
                                            },
                                            child: const Text(
                                              '취소',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 131, 130, 130),
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              elevation:
                                                  MaterialStateProperty.all(
                                                      0.0),
                                            ),
                                            onPressed: () {
                                              return Navigator.of(context)
                                                  .pop(true);
                                            },
                                            child: const Text('삭제',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                )),
                                          ),
                                        ]);
                                  }),
                                );
                              }),
                          Divider(),
                        ]),
                  ),
                ],
              )),
          //ListView(),

          // Expanded(
          //   child: ListView.separated(
          //       padding: const EdgeInsets.symmetric(vertical: 15),
          //       separatorBuilder: (BuildContext context, int indext) =>
          //           const Divider(),
          //       itemCount: noticeTitle.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         int reverseIndex = noticeTitle.length - 1 - index;

          //         return Container(
          //           padding: EdgeInsets.fromLTRB(21, 10, 21, 12),
          //           child: Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text('${noticeTitle[reverseIndex]}',
          //                     style: TextStyle(
          //                         fontSize: 17, fontWeight: FontWeight.w500)),
          //                 SizedBox(height: 7),
          //                 Text('${noticeContent[reverseIndex]}',
          //                     style: TextStyle(
          //                         fontSize: 15, fontWeight: FontWeight.w300)),
          //                 SizedBox(height: 5),
          //                 Text(
          //                   '${noticeDate[reverseIndex]}',
          //                   style: TextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w300,
          //                       color: Color.fromARGB(255, 109, 109, 109)),
          //                 )
        ),
      ),
    );
  }
}
