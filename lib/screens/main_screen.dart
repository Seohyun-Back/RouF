//import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:RouF/component/task_list.dart';
import 'package:RouF/screens/friend_status.dart';
import 'package:RouF/screens/sidebar/friend_list.dart';
import 'package:RouF/screens/sidebar/friend_request.dart';
import 'package:RouF/screens/monthly.dart';
import '../../globals.dart' as globals;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authentication = FirebaseAuth.instance;
  DateTime selectedDate = DateTime.now();
  // int alarmId = 1;
  // DateTime today = DateTime.now();
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
                                        'time': "00H 00m",
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
                                          'time': "00H 00m",
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
    // setState(() {
    //   print("여기 안오나?");
    //   AndroidAlarmManager.oneShotAt(
    //       DateTime(today.year, today.month, today.day, 17, 04, 10),
    //       alarmId,
    //       alarm12);
    // });
    // print("g");
    // AndroidAlarmManager.oneShotAt(
    //     DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 17,
    //         42, 00),
    //     alarmId,
    //     alarm12);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // AppBar 사이즈 지정
        child: AppBar(
          backgroundColor: Colors.white, // AppBar 색상 지정
          leading: Transform.translate(
            offset: Offset(7, 0),
            child: Image.asset(
              'assets/images/logo-black-2.png',
              height: 50,
            ),
          ),

          iconTheme: IconThemeData(color: Color.fromARGB(255, 32, 32, 32)),
          elevation: 0.0,
          centerTitle: false,
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //flex: 2,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                        ),
                      ),
                      Container(
                        //flex: 8,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 6, 0, 30),
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
                                          fontFamily: 'Mono',
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
                                            fontFamily: 'Mono',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300,
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
                    child: Container(
                      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '친구 ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
                                          fontWeight: FontWeight.w500,
                                        ));
                                  }
                                }),
                          ]),
                    ),
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
                    fontFamily: 'Mono',
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () {
                //print("친구 is clicked");
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
                    fontFamily: 'Mono',
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () {
                //print("Setting is clicked");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.grey[850],
              ),
              title: Text('로그아웃',
                  style: TextStyle(
                    fontFamily: 'Mono',
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () {
                globals.initGlobals();
                FirebaseAuth.instance.signOut();
                //print("Logout is clicked");
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
          padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
          // child: SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          child: Column(children: [
            tapableDate(),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                //친구상태창
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
                        return Text('친구를 추가하고 실시간으로 친구들과 일상을 공유해보세요!',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w200));
                        // CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                        );
                      } else {
                        return FriendStatus();
                      } //Text(snapshot.data.toString());
                    }),
              ),
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
