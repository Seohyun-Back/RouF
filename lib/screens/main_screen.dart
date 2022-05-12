import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:RouF/component/task_list.dart';
import 'package:RouF/screens/friend_status.dart';
import 'package:RouF/screens/sidebar/friend_list.dart';
import 'package:RouF/screens/sidebar/friend_request.dart';
import 'package:RouF/screens/monthly.dart';
import 'package:provider/provider.dart';

import '../../globals.dart' as globals;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;
  DateTime selectedDate = DateTime.now();
  List<String> listOfDays = ["월", "화", "수", "목", "금", "토", "일"];

  User? loggedUser;
  //DocumentSnapshot<Map<String, dynamic>>? userData;
  String? userName;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      User user = await _authentication.currentUser!;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserName() async {
    User user = await _authentication.currentUser!;
    final _userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    globals.currentUsername = _userData.data()!['userName'];
    globals.currentUid = _userData.data()!['userUID'];
    globals.currentEmail = _userData.data()!['email'];
    return _userData.data()!['userName'];
  }

  Future<String> getUserEmail() async {
    User user = await _authentication.currentUser!;
    final _userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    return await loggedUser!.email.toString();
  }

  Future<String> getUID() async {
    User user = await _authentication.currentUser!;
    final _userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    globals.currentUsername = _userData.data()!['userName'];
    globals.currentUid = _userData.data()!['userUID'];
    globals.currentEmail = _userData.data()!['email'];
    return _userData.data()!['userUID'];
  }

  Future<int> getFriendNum() async {
    User user = await _authentication.currentUser!;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('friends')
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    globals.friendNum = _myDocCount.length;
    if (_myDocCount.length == 0) return 0;
    return await _myDocCount.length;
  }

  Widget tapableDate() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MonthlyWork();
          }),
        );
      },
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 16,
          ),
          Text(
            selectedDate.year.toString() +
                "/" +
                selectedDate.month.toString() +
                "/" +
                selectedDate.day.toString() +
                " (" +
                listOfDays[selectedDate.weekday - 1] +
                ")",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void addCategory(context) {
    BuildContext dialogContext;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        // return object of type Dialog
        return AlertDialog(
          title: new Text("할 일 추가",
              style: TextStyle(
                fontSize: 14,
              )),
          //content: new Text("Alert Dialog body"),
          content: Container(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: Row(children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        IconButton(
                            icon: Image.asset(
                                'assets/images/TaskIcon/${globals.tasks[i]}.png'),
                            iconSize: 20,
                            onPressed: () async {
                              Navigator.pop(dialogContext);
                              //globals.statusKey = i;
                              globals.taskList.contains(i)
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content: Text("이미 추가된 카테고리입니다."),
                                    ))
                                  : {
                                      await FirebaseFirestore.instance
                                          .collection(
                                              'user/${globals.currentUid}/tasks')
                                          .doc(i.toString())
                                          .set({
                                        'taskKey': i,
                                        'title': globals.tasks[i],
                                        'time': "00:00",
                                        //'todos': Map(),
                                      }),
                                      setState(() {
                                        globals.taskList.add(i);
                                      }),
                                    };
                            }),

                        //print(globals.statusKey);
                        //setState(() {});

                        //AddTask;
                        //addDynamic();
                        //new AddTask();
                        Text(
                          globals.tasks[i],
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
              ])),
              Row(
                children: [
                  for (int i = 4; i < 8; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          IconButton(
                              icon: Image.asset(
                                  'assets/images/TaskIcon/${globals.tasks[i]}.png'),
                              iconSize: 20,
                              onPressed: () async {
                                Navigator.pop(dialogContext);
                                //globals.statusKey = i;
                                globals.taskList.contains(i)
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text("이미 추가된 카테고리입니다."),
                                      ))
                                    : {
                                        await FirebaseFirestore.instance
                                            .collection(
                                                'user/${globals.currentUid}/tasks')
                                            .doc(i.toString())
                                            .set({
                                          'taskKey': i,
                                          'title': globals.tasks[i],
                                          'time': "00:00",
                                        }),
                                        setState(() {
                                          globals.taskList.add(i);
                                        }),
                                      };
                              }),
                          Text(
                            globals.tasks[i],
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                ],
              )
            ],
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          leading: Image.asset(
            'assets/images/logo-black-2.png',
            height: 50,
          ),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
          elevation: 0.0,

          centerTitle: true,
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                  child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/profile1.jpg'),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                  future: getUserName(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == false) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text(
                                        'Error: ${snapshot.error}',
                                      );
                                    } else {
                                      return Text(
                                        snapshot.data.toString(),
                                        style: TextStyle(
                                          fontFamily: 'nanum-gothic',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ); //Text(snapshot.data.toString());
                                    }
                                  }),
                              FutureBuilder(
                                  future: getUserEmail(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData == false) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text(
                                        'Error: ${snapshot.error}',
                                      );
                                    } else {
                                      return Text(snapshot.data.toString(),
                                          style: TextStyle(
                                            fontFamily: 'nanum-gothic',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ));
                                    }
                                  }),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Tapped Friend List!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return FriendList();
                        }),
                      );
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '친구 ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          FutureBuilder(
                              future: getFriendNum(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                    'Error: ${snapshot.error}',
                                  );
                                } else {
                                  return Text(snapshot.data.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ));
                                }
                              }),
                        ]),
                  ),
                ],
              )),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                  )),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.grey[850],
              ),
              title: Text('친구 신청',
                  style: TextStyle(
                    fontFamily: 'nanum-gothic',
                    fontWeight: FontWeight.w600,
                  )),
              onTap: () {
                print("친구 is clicked");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return FriendRequest();
                  }),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('설정',
                  style: TextStyle(
                    fontFamily: 'nanum-gothic',
                    fontWeight: FontWeight.w600,
                  )),
              onTap: () {
                print("Setting is clicked");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.grey[850],
              ),
              title: Text('로그아웃',
                  style: TextStyle(
                    fontFamily: 'nanum-gothic',
                    fontWeight: FontWeight.w600,
                  )),
              onTap: () {
                globals.initGlobals();
                FirebaseAuth.instance.signOut();
                print("Logout is clicked");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          onPressed: () {
            addCategory(context);
          }),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
          // child: SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          child: Column(children: [
            tapableDate(),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 220,
              width: 330,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: FutureBuilder(
                  future: getUID(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData == false) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                      );
                    } else {
                      return FriendStatus();
                    } //Text(snapshot.data.toString());
                  }),
            ),
            SizedBox(
              height: 5,
              width: 330,
            ),
            SafeArea(
              child: TaskList(),
            )
          ]),
          // ),
        ),
      ),
    );
  }
}
// import 'package:RouF/screens/monthly.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:RouF/screens/sidebar/friend_request.dart';
// import 'package:RouF/screens/sidebar/friend_list.dart';
// import 'package:RouF/globals.dart' as globals;
// import '../component/task_list.dart';
// import '../component/stopwatch.dart';

// import 'calendar_screen.dart';
// //import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   DateTime selectedDate = DateTime.now();
//   List<String> listOfDays = ["월", "화", "수", "목", "금", "토", "일"];
//   final _authentication = FirebaseAuth.instance;

//   User? loggedUser;
//   String? userName;

//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   // Future<void> addDynamic() async {
//   //   print(globals.statusKey);
//   //   if (globals.addTaskList.length != 0) {
//   //     //floatingIcon = new Icon(Icons.add);
//   //     globals.addTaskList = [];
//   //   }

//   //   globals.addTaskList.add(AddTask());
//   //   print(globals.addTaskList.length.toString());
//   //   setState(() {});
//   // }

//   // Widget dynamicTaskList = Column(
//   //   children: [
//   //     Flexible(
//   //       //flex: 2,
//   //       child: ListView.builder(
//   //         itemCount: globals.addTaskList.length,
//   //         itemBuilder: (_, index) => globals.addTaskList[index],
//   //       ),
//   //     )
//   //   ],
//   // );

//   void getCurrentUser() async {
//     try {
//       User user = await _authentication.currentUser!;
//       if (user != null) {
//         loggedUser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<String> getUserName() async {
//     User user = await _authentication.currentUser!;
//     final _userData =
//         await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

//     while (_userData.data() == null) {
//       Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     globals.currentUsername = _userData.data()!['userName'];
//     globals.currentUid = _userData.data()!['userUID'];
//     globals.currentEmail = _userData.data()!['email'];
//     //globals.statusKey = 8;
//     return _userData.data()!['userName'];
//   }

//   Future<String> getUserEmail() async {
//     // 여력이 된다면 이거 해결하기..
//     // 불러오는 코드 필요 없는데 빼면 실행 순서 꼬여서 오류남 ㅜㅜ

//     User user = await _authentication.currentUser!;
//     final _userData =
//         await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

//     return await loggedUser!.email.toString();
//   }

//   Future<int> getFriendNum() async {
//     User user = await _authentication.currentUser!;
//     QuerySnapshot _myDoc = await FirebaseFirestore.instance
//         .collection('user')
//         .doc(user.uid)
//         .collection('friends')
//         .get();
//     List<DocumentSnapshot> _myDocCount = _myDoc.docs;
//     globals.friendNum = _myDocCount.length;
//     if (_myDocCount.length == 0) return 0;
//     return await _myDocCount.length;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
//           child: AppBar(
//             backgroundColor: Colors.white, // AppBar 색상 지정
//             leading: Image.asset(
//               'assets/images/logo-black-2.png',
//               //fit: BoxFit.contain,
//               height: 50,
//             ),
//             iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
//             elevation: 0.0,

//             centerTitle: true,
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             scrollDirection: Axis.vertical,
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 child: Container(
//                     child: Column(children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundImage:
//                               AssetImage('assets/images/profile1.jpg'),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 8,
//                         child: Container(
//                           padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               FutureBuilder(
//                                   future: getUserName(),
//                                   builder: (BuildContext context,
//                                       AsyncSnapshot snapshot) {
//                                     if (snapshot.hasData == false) {
//                                       return CircularProgressIndicator();
//                                     } else if (snapshot.hasError) {
//                                       return Text(
//                                         'Error: ${snapshot.error}',
//                                       );
//                                     } else {
//                                       return Text(
//                                         snapshot.data.toString(),
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       );
//                                     }
//                                   }),
//                               FutureBuilder(
//                                   future: getUserEmail(),
//                                   builder: (BuildContext context,
//                                       AsyncSnapshot snapshot) {
//                                     if (snapshot.hasData == false) {
//                                       return CircularProgressIndicator();
//                                     } else if (snapshot.hasError) {
//                                       return Text(
//                                         'Error: ${snapshot.error}',
//                                       );
//                                     } else {
//                                       return Text(snapshot.data.toString(),
//                                           style: TextStyle(
//                                               //color: Colors.white,
//                                               ));
//                                     }
//                                   }),
//                               // StreamBuilder(
//                               //   stream: FirebaseFirestore.instance
//                               //       .collection(
//                               //           'user/${globals.currentUid}/friends')
//                               //       .snapshots(),
//                               //   builder: (BuildContext context,
//                               //       AsyncSnapshot<dynamic> snapshot) {
//                               //     if (snapshot.connectionState ==
//                               //         ConnectionState.waiting) {
//                               //       return Center(
//                               //         child: CircularProgressIndicator(),
//                               //       );
//                               //     }
//                               //     final docs = snapshot.data!.docs;
//                               //     return TextButton(
//                               //       onPressed: () {
//                               //         print('친구 목록 창으로 넘어갈거임~');
//                               //       },
//                               //       child: Text('친구 ${docs.length.toString()}',
//                               //           style: TextStyle(
//                               //             color: Colors.black,
//                               //             fontSize: 11,
//                               //           )),
//                               //     );
//                               //   },
//                               // ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                   //   Text(
//                   //     '친구 ',
//                   //     style: TextStyle(
//                   //       fontSize: 16,
//                   //     ),
//                   //   ),
//                   //   FutureBuilder(
//                   //       future: getFriendNum(),
//                   //       builder:
//                   //           (BuildContext context, AsyncSnapshot snapshot) {
//                   //         if (snapshot.hasError) {
//                   //           return Text(
//                   //             'Error: ${snapshot.error}',
//                   //           );
//                   //         } else {
//                   //           return Text(snapshot.data.toString(),
//                   //               style: TextStyle(
//                   //                 fontSize: 16,
//                   //               ));
//                   //         }
//                   //       }),
//                   // ]),
//                   GestureDetector(
//                     onTap: () {
//                       print('Tapped Friend List!');
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return FriendList();
//                         }),
//                       );
//                     },
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             '친구 ',
//                             style: TextStyle(
//                               fontSize: 16,
//                             ),
//                           ),
//                           FutureBuilder(
//                               future: getFriendNum(),
//                               builder: (BuildContext context,
//                                   AsyncSnapshot snapshot) {
//                                 if (snapshot.hasError) {
//                                   return Text(
//                                     'Error: ${snapshot.error}',
//                                   );
//                                 } else {
//                                   return Text(snapshot.data.toString(),
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                       ));
//                                 }
//                               }),
//                         ]),
//                   ),
//                 ])),
//                 decoration: BoxDecoration(
//                     color: Colors.green[200],
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(20.0),
//                       bottomRight: Radius.circular(20.0),
//                     )),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.favorite,
//                   color: Colors.grey[850],
//                 ),
//                 title: Text('친구'),
//                 onTap: () {
//                   print("친구 is clicked");
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return FriendRequest();
//                   }));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.settings,
//                   color: Colors.grey[850],
//                 ),
//                 title: Text('설정'),
//                 onTap: () {
//                   print("Setting is clicked");
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.exit_to_app,
//                   color: Colors.grey[850],
//                 ),
//                 title: Text('로그아웃'),
//                 onTap: () async {
//                   await StopwatchPage(index: -1, taskKey: -1);
//                   //putFirebase();
//                   globals.initGlobals();
//                   FirebaseAuth.instance.signOut();
//                   //globals.statusKey = 8;
//                   print("Logout is clicked");
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           children: [
//             Flexible(
//               child: Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextButton.icon(
//                       onPressed: () {
//                         //CalendarScreen();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => CalendarScreen()));
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios_rounded,
//                         color: Colors.black,
//                         size: 16,
//                       ),
//                       label: Text(
//                           selectedDate.year.toString() +
//                               "/" +
//                               selectedDate.month.toString() +
//                               "/" +
//                               selectedDate.day.toString() +
//                               " (" +
//                               listOfDays[selectedDate.weekday - 1] +
//                               ")",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                           )),
//                     ),
//                     Container(
//                       height: 220,
//                     ),

//                     SafeArea(
//                       child: TaskList(),
//                     )
//                     //       Container(
//                     //           //width: 200,
//                     //           child: Column(
//                     //         children: <Widget>[
//                     //           Expanded(
//                     //               child: ListView.builder(
//                     //                   itemCount: globals.addTaskList.length,
//                     //                   itemBuilder: (_, index) =>
//                     //                       globals.addTaskList[index])),
//                     //         ],
//                     //       ))
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             addCategory(context);
//             print("floating buttons is clicked");
//           },
//           child: Icon(Icons.add),
//         ));
//   }

//   Widget tapableDate() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) {
//             return MonthlyWork();
//           }),
//         );
//       },
//       child: Row(
//         children: [
//           Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.black,
//             size: 16,
//           ),
//           Text(
//             selectedDate.year.toString() +
//                 "/" +
//                 selectedDate.month.toString() +
//                 "/" +
//                 selectedDate.day.toString() +
//                 " (" +
//                 listOfDays[selectedDate.weekday - 1] +
//                 ")",
//             style: TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   void addCategory(context) {
//     BuildContext dialogContext;
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         dialogContext = context;
//         // return object of type Dialog
//         return AlertDialog(
//           title: new Text("할 일 추가",
//               style: TextStyle(
//                 fontSize: 14,
//               )),
//           //content: new Text("Alert Dialog body"),
//           content: Container(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                   child: Row(children: [
//                 for (int i = 0; i < 4; i++)
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Column(
//                       children: [
//                         IconButton(
//                             icon: Image.asset(
//                                 'assets/images/TaskIcon/${globals.tasks[i]}.png'),
//                             iconSize: 20,
//                             onPressed: () async {
//                               Navigator.pop(dialogContext);
//                               //globals.statusKey = i;
//                               globals.taskList.contains(i)
//                                   ? ScaffoldMessenger.of(context)
//                                       .showSnackBar(SnackBar(
//                                       content: Text("이미 추가된 카테고리입니다."),
//                                     ))
//                                   : {
//                                       await FirebaseFirestore.instance
//                                           .collection(
//                                               'user/${globals.currentUid}/tasks')
//                                           .doc(i.toString())
//                                           .set({
//                                         'taskKey': i,
//                                         'title': globals.tasks[i],
//                                         'time': "00:00",
//                                         //'todos': Map(),
//                                       }),
//                                       setState(() {
//                                         globals.taskList.add(i);
//                                       }),
//                                     };
//                             }),

//                         //print(globals.statusKey);
//                         //setState(() {});

//                         //AddTask;
//                         //addDynamic();
//                         //new AddTask();
//                         Text(
//                           globals.tasks[i],
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//               ])),
//               Row(
//                 children: [
//                   for (int i = 4; i < 8; i++)
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Column(
//                         children: [
//                           IconButton(
//                               icon: Image.asset(
//                                   'assets/images/TaskIcon/${globals.tasks[i]}.png'),
//                               iconSize: 20,
//                               onPressed: () async {
//                                 Navigator.pop(dialogContext);
//                                 //globals.statusKey = i;
//                                 globals.taskList.contains(i)
//                                     ? ScaffoldMessenger.of(context)
//                                         .showSnackBar(SnackBar(
//                                         content: Text("이미 추가된 카테고리입니다."),
//                                       ))
//                                     : {
//                                         await FirebaseFirestore.instance
//                                             .collection(
//                                                 'user/${globals.currentUid}/tasks')
//                                             .doc(i.toString())
//                                             .set({
//                                           'taskKey': i,
//                                           'title': globals.tasks[i],
//                                           'time': "00:00",
//                                         }),
//                                         setState(() {
//                                           globals.taskList.add(i);
//                                         }),
//                                       };
//                               }),
//                           Text(
//                             globals.tasks[i],
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               )
//             ],
//           )),
//         );
//       },
//     );
//   }

//   // void putFirebase() {
//   //   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // }
// }

// //class TaskList {}
