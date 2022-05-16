import 'package:flutter/material.dart';

class NoticeBoard extends StatelessWidget {
  NoticeBoard({Key? key}) : super(key: key);

  final List<String> noticeTitle = <String>[
    'RouF 오픈!',
    '오늘 일기 기능 추가',
    'From Prom 전시회 오픈',
  ];
  final List<String> noticeContent = <String>[
    '정해진 카테고리를 추가함으로써 하루 일과를 기록ㆍ확인하고, 친구들이 실시간으로 무엇을 하고 있는지 볼 수 있는 모바일 앱서비스 RouF가 오픈했습니다.\n터치 한번으로 그날 한 일을 쉽게 기록해보세요.',
    '오늘 하루 일을 간단하게 적을 수 있는 오늘 일기 기능이 추가되었습니다. 작성한 오늘 일기는 메인 스크린의 날짜 탭을 누르면 볼 수 있는 월별 정리 페이지에서 확인할 수 있습니다.\n매일의 기분을 기록해보세요.',
    '글로벌미디어학부 졸업 전시회 From Prom 이 오픈했습니다!\n전시회에서 최초 공개될 RouF를 즐겨보세요, RouF의 깜짝 굿즈 선물도 있습니다.',
    'D',
    'E',
    'F'
  ];
  final List<String> noticeDate = <String>[
    'April 30, 2022',
    'May 16, 2022',
    'May 20, 2022',
    'D',
    'E',
    'F'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
          child: AppBar(
            backgroundColor: Colors.white, // AppBar 색상 지정
            title: Text('공지사항', style: TextStyle(color: Colors.black)),

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
            child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  separatorBuilder: (BuildContext context, int indext) =>
                      const Divider(),
                  itemCount: noticeTitle.length,
                  itemBuilder: (BuildContext context, int index) {
                    int reverseIndex = noticeTitle.length - 1 - index;

                    return Container(
                      padding: EdgeInsets.fromLTRB(21, 10, 21, 12),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${noticeTitle[reverseIndex]}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500)),
                            SizedBox(height: 7),
                            Text('${noticeContent[reverseIndex]}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300)),
                            SizedBox(height: 5),
                            Text(
                              '${noticeDate[reverseIndex]}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 109, 109, 109)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        )));
  }
}
