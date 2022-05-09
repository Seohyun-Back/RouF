import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
      child: Text(
        "monthly",
      ),
    )));
  }
}

// import 'package:flutter/material.dart';

// class CalendarScreen extends StatefulWidget {
//   const CalendarScreen({Key? key}) : super(key: key);

//   @override
//   State<CalendarScreen> createState() => _CalendarScreenState();
// }

// class _CalendarScreenState extends State<CalendarScreen> {
//   DateTime selectedDate = DateTime.now(); // TO tracking date

//   int currentDateSelectedIndex = 0; //For Horizontal Date
//   ScrollController scrollController =
//       ScrollController(); //To Track Scroll of ListView

//   List<String> listOfMonths = [
//     "January",
//     "February",
//     "March",
//     "April",
//     "May",
//     "June",
//     "July",
//     "August",
//     "September",
//     "October",
//     "November",
//     "December"
//   ];

//   //List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         //mainAxisSize: MainAxisSize.min,
//         children: [
//           //To Show Current Date
//           Center(
//             child: Container(
//               height: 30,
//               margin: EdgeInsets.only(left: 10),
//               alignment: Alignment.center,
//               child: Text(
//                   listOfMonths[selectedDate.month - 1] +
//                       ' ' +
//                       selectedDate.year.toString(),
//                   style: TextStyle(
//                     fontSize: 18,
//                   )),

//               // child: Text(
//               //   selectedDate.day.toString() +
//               //       '-' +
//               //       listOfMonths[selectedDate.month - 1] +
//               //       ', ' +
//               //       selectedDate.year.toString(),
//               //   style: TextStyle(
//               //       fontSize: 18,
//               //       fontWeight: FontWeight.w800,
//               //       color: Colors.indigo[700]),
//               // )
//             ),
//           ),
//           SizedBox(height: 10),
//           //To show Calendar Widget
//           Container(
//               height: 30,
//               child: Container(
//                   child: ListView.separated(
//                 separatorBuilder: (BuildContext context, int index) {
//                   return SizedBox(width: 10);
//                 },
//                 itemCount: 7,
//                 controller: scrollController,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index) {
//                   return InkWell(
//                     onTap: () {
//                       setState(() {
//                         currentDateSelectedIndex = index;
//                         selectedDate =
//                             DateTime.now().add(Duration(days: index));
//                       });
//                     },
//                     child: Container(
//                       //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                       height: 30,
//                       width: 30,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           // boxShadow: [
//                           //   BoxShadow(
//                           //       color: Colors.grey[400],
//                           //       offset: Offset(3, 3),
//                           //       blurRadius: 5)
//                           // ],
//                           color: currentDateSelectedIndex == index
//                               ? Colors.green
//                               : Colors.white),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // Text(
//                           //   listOfMonths[DateTime.now()
//                           //               .add(Duration(days: index))
//                           //               .month -
//                           //           1]
//                           //       .toString(),
//                           //   style: TextStyle(
//                           //       fontSize: 16,
//                           //       color: currentDateSelectedIndex == index
//                           //           ? Colors.white
//                           //           : Colors.grey),
//                           // ),
//                           // SizedBox(
//                           //   height: 5,
//                           // ),
//                           Text(
//                             DateTime.now()
//                                 .add(Duration(days: index))
//                                 .day
//                                 .toString(),
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 //fontWeight: FontWeight.w700,
//                                 color: currentDateSelectedIndex == index
//                                     ? Colors.white
//                                     : Colors.grey),
//                           ),
//                           // SizedBox(
//                           //   height: 5,
//                           // ),
//                           // Text(
//                           //   listOfDays[DateTime.now()
//                           //               .add(Duration(days: index))
//                           //               .weekday -
//                           //           1]
//                           //       .toString(),
//                           //   style: TextStyle(
//                           //       fontSize: 16,
//                           //       color: currentDateSelectedIndex == index
//                           //           ? Colors.white
//                           //           : Colors.grey),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ))),
//         ],
//       ),
//     );
//   }
// }
// // import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

// // class CalendarScreen extends StatefulWidget {
// //   const CalendarScreen({Key? key}) : super(key: key);

// //   @override
// //   State<CalendarScreen> createState() => _CalendarScreenState();
// // }

// // class _CalendarScreenState extends State<CalendarScreen> {
// //   // List<NeatCleanCalendarEvent> _todaysEvents = [
// //   //   NeatCleanCalendarEvent('Event A',
// //   //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
// //   //           DateTime.now().day, 10, 0),
// //   //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
// //   //           DateTime.now().day, 12, 0),
// //   //       description: 'A special event',
// //   //       color: Colors.blue[700]),
// //   // ];
// //   // final List<NeatCleanCalendarEvent> _eventList = [
// //   //   NeatCleanCalendarEvent('MultiDay Event A',
// //   //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
// //   //           DateTime.now().day, 10, 0),
// //   //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
// //   //           DateTime.now().day + 2, 12, 0),
// //   //       color: Colors.orange,
// //   //       isMultiDay: true),
// //   //   NeatCleanCalendarEvent('Allday Event B',
// //   //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
// //   //           DateTime.now().day - 2, 14, 30),
// //   //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
// //   //           DateTime.now().day + 2, 17, 0),
// //   //       color: Colors.pink,
// //   //       isAllDay: true),
// //   //   NeatCleanCalendarEvent('Normal Event D',
// //   //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
// //   //           DateTime.now().day, 14, 30),
// //   //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
// //   //           DateTime.now().day, 17, 0),
// //   //       color: Colors.indigo),
// //   // ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Force selection of today on first load, so that the list of today's events gets shown.
// //     _handleNewDate(DateTime(
// //         DateTime.now().year, DateTime.now().month, DateTime.now().day));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Calendar(
// //         startOnMonday: true,
// //         weekDays: [], //['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
// //         eventsList: null,
// //         isExpandable: false,
// //         eventDoneColor: null, //Colors.green,
// //         selectedColor: null, //Colors.pink,
// //         todayColor: null, //Colors.blue,
// //         eventColor: null,
// //         //locale: 'de_DE',
// //         todayButtonText: '', //'Heute',
// //         allDayEventText: '', //'Ganztägig',
// //         multiDayEndText: '', //'Ende',
// //         isExpanded: true,
// //         expandableDateFormat: 'EEEE, dd. MMMM yyyy',
// //         datePickerType: DatePickerType.date,
// //         dayOfWeekStyle: TextStyle(
// //             color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
// //       ),
// //       // floatingActionButton: FloatingActionButton(
// //       //   onPressed: () {},
// //       //   child: const Icon(Icons.add),
// //       //   backgroundColor: Colors.green,
// //       // ),
// //     );
// //   }

// //   void _handleNewDate(date) {
// //     print('Date selected: $date');
// //   }
// // }
