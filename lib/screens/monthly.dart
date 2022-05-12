import 'package:cloud_firestore/cloud_firestore.dart';
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
                    height: 420.0,
                    selectedDateTime: selectedDate,
                    daysHaveCircularBorder: true,

                    /// null for not rendering any border, true for circular border, false for rectangular border
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 18, 20, 20),
                height: 400,
                width: 320,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('listview 만들자'),
                // child: Column(
                //   children: [
                //     StreamBuilder(
                //       stream: FirebaseFirestore.instance
                //           .collection('user/${globals.currentUid}/friends')
                //           .snapshots(),
                //       builder: (BuildContext context,
                //           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                //               snapshot) {
                //         if (snapshot.connectionState ==
                //             ConnectionState.waiting) {
                //           return Center(
                //             child: CircularProgressIndicator(),
                //           );
                //         }
                //         final docs = snapshot.data!.docs;

                //         return Container(
                //           height: 218,
                //           child: ListView.builder(
                //             scrollDirection: Axis.vertical,
                //             shrinkWrap: true,
                //             itemCount: docs.length,
                //             itemBuilder: (context, index) {
                //               return StreamBuilder(
                //                   stream: FirebaseFirestore.instance
                //                       .collection('user')
                //                       .doc('${docs[index]['uid']}')
                //                       .snapshots(),
                //                   builder: (BuildContext context,
                //                       AsyncSnapshot<
                //                               DocumentSnapshot<
                //                                   Map<String, dynamic>>>
                //                           snapshot2) {
                //                     if (snapshot.connectionState ==
                //                         ConnectionState.waiting) {
                //                       return Center(
                //                         child: CircularProgressIndicator(),
                //                       );
                //                     }
                //                     actionKey = snapshot2.data!['statusKey'];

                //                     return Container(
                //                         //padding:,
                //                         child: ListTile(
                //                       horizontalTitleGap: 6.0,
                //                       dense: true,
                //                       // 친구 프로필사진
                //                       leading: CircleAvatar(
                //                         radius: 18,
                //                         backgroundColor: Color(0xff95DF7D),
                //                         child: Image.asset(
                //                           'images/TaskIcon/${globals.tasks[actionKey]}.png',
                //                           height: 20,
                //                           width: 20,
                //                         ),
                //                       ),
                //                       // 친구 이름
                //                       title: Text(
                //                           docs[index]['name'] +
                //                               '는 ' +
                //                               globals.action[actionKey],
                //                           style: TextStyle(fontSize: 18)),
                //                     ));
                //                   });
                //             },
                //           ),
                //         );
                //       },
                //     )
                //   ],
                // )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
