import 'package:flutter/material.dart';

class FaqBoard extends StatelessWidget {
  FaqBoard({Key? key}) : super(key: key);

  final List<String> faqQuestion = <String>[
    '기록해둔 일과 시간은 어디서 볼 수 있나요?',
    '친구 목록은 어디서 확인할 수 있나요?',
    '아무것도 하고 있지 않을 때 제 상태는 친구들한테 어떻게 보이나요?',
  ];
  final List<String> faqAnswer = <String>[
    '기록해둔 하루 일과 시간과 오늘 일기는 메인 스크린 상단의 금일 날짜를 탭하면 뜨는 월별 정리 페이지에서 확인하실 수 있습니다.\n원하는 날짜를 눌러서 그 날의 일상을 다시 떠올려보세요.',
    '메인스크린에서 오른쪽 상단의 메뉴버튼을 누르면 뜨는 드로어에서 친구 수를 누르면 친구 목록을 볼 수 있고, 친구 삭제도 할 수 있습니다.',
    '작동중인 스톱워치가 없을 때는 친구들에게 \'OO님은 숨 쉬는 중\'으로 보입니다.',
    'D',
    'E',
    'F'
  ];
  final List<String> faqTip = <String>[
    '',
    '받은 친구 신청은 친구수 하단의 \'친구 신청\'에서 볼 수 있습니다',
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
            title: Text('FAQ', style: TextStyle(color: Colors.black)),

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RouF 100% 활용하기',
                  style: TextStyle(
                      color: Color.fromARGB(255, 5, 98, 8),
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              // SizedBox(
              //   height: 40,
              // ),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: faqQuestion.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(7, 10, 7, 12),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Q. ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  Flexible(
                                    child: Text('${faqQuestion[index]}',
                                        maxLines: 10,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            letterSpacing: -0.2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('A. ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Flexible(
                                    child: Text('${faqAnswer[index]}',
                                        maxLines: 10,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('   ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Flexible(
                                    child: Text(
                                      '${faqTip[index]}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w200,
                                          color: Color.fromARGB(
                                              233, 152, 151, 151)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        )));
  }
}
