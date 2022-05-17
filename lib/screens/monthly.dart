import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:RouF/globals.dart' as globals;

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class MonthlyWork extends StatefulWidget {
  const MonthlyWork({Key? key}) : super(key: key);

  @override
  State<MonthlyWork> createState() => _MonthlyWorkState();
}

class _MonthlyWorkState extends State<MonthlyWork> {
  DateTime selectedDate = DateTime.now();
  late String dateKey = selectedDate.toString().substring(2, 4) +
      selectedDate.toString().substring(5, 7) +
      selectedDate.toString().substring(8, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 23.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: CalendarCarousel<Event>(
                    onDayPressed: (DateTime date, List<Event> events) {
                      this.setState(() => selectedDate = date);
                      print('selected date is : ${selectedDate}');
                      dateKey = selectedDate.toString().substring(2, 4) +
                          selectedDate.toString().substring(5, 7) +
                          selectedDate.toString().substring(8, 10);
                    },
                    thisMonthDayBorderColor: Colors.transparent,
                    headerTextStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'rouf-font',
                      fontSize: 20.0,
                    ),
                    iconColor: Colors.black,
                    weekdayTextStyle:
                        TextStyle(fontSize: 14.0, color: Colors.grey),
                    weekendTextStyle:
                        TextStyle(fontSize: 15.0, color: Colors.black),
                    todayTextStyle:
                        TextStyle(fontSize: 15.0, color: Colors.black),
                    todayBorderColor: Colors.transparent,
                    todayButtonColor: Color.fromARGB(255, 245, 242, 242),
                    weekFormat: false,
                    height: MediaQuery.of(context).size.height * 0.42,
                    selectedDateTime: selectedDate,
                    daysHaveCircularBorder: true,

                    /// null for not rendering any border, true for circular border, false for rectangular border
                  ),
                ),
              ),
              Container(
                  //padding: EdgeInsets.fromLTRB(20, 18, 20, 20),
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.grey,
                  //   ),
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  //child: Text('listview 만들자'),
                  child: Column(
                    children: [
                      //Text(selectedDate.toString().substring(0, 10)),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(
                                'user/${globals.currentUid}/data/${dateKey}/task')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          return Expanded(
                              flex: 2,
                              // height: MediaQuery.of(context).size.height * 0.4,
                              // width: MediaQuery.of(context).size.width * 0.8,

                              child: snapshot.data?.docs.length == 0
                                  ? Container(
                                      //padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Center(
                                      child: Text(
                                        "기록된 활동이 없습니다.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                  : Center(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data?.docs.length,
                                        itemBuilder: (ctx, index) => Container(
                                          padding: EdgeInsets.all(8),
                                          child: ListTile(
                                            dense: true,
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Color(0xffddeacf),
                                              child: Image.asset(
                                                'assets/images/TaskIcon/${snapshot.data?.docs[index]['task']}.png',
                                                height: 25,
                                                width: 25,
                                              ),
                                            ),
                                            title: Row(children: [
                                              Text(snapshot.data?.docs[index]
                                                  ['task']),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              // width: MediaQuery.of(context)
                                              //         .size
                                              //         .width *
                                              //     0.2),
                                              Text(snapshot.data?.docs[index]
                                                  ['time']),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ));
                        },
                      ),
                      Divider(color: Colors.black),
                      Expanded(
                          flex: 1,
                          child: FutureBuilder(
                              future: getDiaryContext(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                                // if (snapshot.hasData == false) {
                                //   return CircularProgressIndicator();
                                // } else if (snapshot.hasError) {
                                //   return Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Text(
                                //       'Error: ${snapshot.error}',
                                //       style: TextStyle(fontSize: 15),
                                //     ),
                                //   );
                                // } else {
                                return Container(
                                  //padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      snapshot.data.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                );
                                //}
                              }))
                      // child: Center(child: Text(getDiaryContext()))),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getDiaryContext() async {
    String context = '';
    final diarycontext = await FirebaseFirestore.instance
        .collection('user/${globals.currentUid}/data/${dateKey}/diary')
        .doc('diary')
        .get();
    print(diarycontext.data());
    if (diarycontext.data() != null) {
      context = diarycontext.data()!['content'];
    } else {
      context = "기록된 일기가 없습니다.";
    }

    return context;
  }
}
