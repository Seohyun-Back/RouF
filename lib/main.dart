import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:RouF/screens/login_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'screens/main_screen.dart';
import 'globals.dart' as globals;
//import 'profileSet.dart';

//DateTime today = DateTime.now();

const MaterialColor primaryGreen = MaterialColor(
  _greenPrimaryValue,
  <int, Color>{
    50: Color(0xFF47992A),
    100: Color(0xFF47992A),
    200: Color(0xFF47992A),
    300: Color(0xFF47992A),
    400: Color(0xFF47992A),
    500: Color(_greenPrimaryValue),
    600: Color(0xFF47992A),
    700: Color(0xFF47992A),
    800: Color(0xFF47992A),
    900: Color(0xFF47992A),
  },
);
const int _greenPrimaryValue = 0xFF47992A;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await AndroidAlarmManager.initialize();
  runApp(MyApp());
}

//int alarmId = 1;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryGreen,
        fontFamily: 'Mono',
      ),
      //home: MyPage(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // bool isOn = false;
          // if (isOn == true) {
          // AndroidAlarmManager.oneShotAt(
          //     DateTime(today.year, today.month, today.day + 1, 00, 00, 00),
          //     alarmId,
          //     alarm12);
          // print("g");
          // AndroidAlarmManager.oneShotAt(
          //     DateTime(today.year, today.month, today.day, 17, 36, 00),
          //     alarmId,
          //     alarm12);
          //   isOn = false;
          // } else {
          //   AndroidAlarmManager.cancel(alarmId);
          //}

          if (snapshot.hasData) {
            return MainScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}

// final _authentication = FirebaseAuth.instance;
// User? loggedUser;
// void getCurrentUser() async {
//   try {
//     User user = await _authentication.currentUser!;
//     if (user != null) {
//       loggedUser = user;
//     }
//   } catch (e) {
//     print(e);
//   }
// }

// Future<String> getUserName() async {
//   User user = await _authentication.currentUser!;
//   final _userData =
//       await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
//   globals.currentUsername = _userData.data()!['userName'];
//   globals.currentUid = _userData.data()!['userUID'];
//   globals.currentEmail = _userData.data()!['email'];
//   return _userData.data()!['userName'];
// }

// Future<String> getUserEmail() async {
//   User user = await _authentication.currentUser!;
//   final _userData =
//       await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

//   return await loggedUser!.email.toString();
// }

// Future<String> getUID() async {
//   Firebase.initializeApp();
//   User user = await _authentication.currentUser!;
//   final _userData =
//       await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
//   //globals.currentUsername = _userData.data()!['userName'];
//   globals.currentUid = _userData.data()!['userUID'];
//   //globals.currentEmail = _userData.data()!['email'];
//   return _userData.data()!['userUID'];
// }

// Future<int> countDocuments() async {
//   QuerySnapshot _myDoc =
//       await FirebaseFirestore.instance.collection('user/${getUID}/tasks').get();
//   List<DocumentSnapshot> _myDocCount = _myDoc.docs;
//   print(_myDocCount.length);
//   return _myDocCount.length; // Count of Documents in Collection
// }

// void alarm12() async {
//   DateTime today = DateTime.now();
//   print(today.hour.toString() +
//       " : " +
//       today.minute.toString() +
//       " : " +
//       today.second.toString() +
//       "호출됐어요!");
//   getCurrentUser();
//   print("currentUid : " + globals.currentUid);
//   await Firebase.initializeApp();
//   // var firestore = await FirebaseFirestore.instance
//   //     .collection('user/${getUID()}/days')
//   //     .doc(today.month.toString() + today.day.toString());

//   Future<int> taskCnt = countDocuments();
//   // for (int i = 0; i < taskCnt; i++) {
//   //   String task;
//   //   String time;

//   //   await FirebaseFirestore.instance
//   //       .collection('user/${getUID()}/days')
//   //       .doc(today.month.toString() + today.day.toString())
//   //       .set({
//   //     globals.tasks[globals.taskList[i]]:
//   //         globals.eachTaskTimer[globals.taskList[i]]
//   //   });
//   // }
//   print("엥? " + globals.taskList.toString());
//   globals.todos = [
//     [],
//     [],
//     [],
//     [],
//     [],
//     [],
//     [],
//     [],
//   ];
//   globals.taskList = [];
//   globals.eachTaskKey = [0, 0, 0, 0, 0, 0, 0, 0];
//   globals.eachTaskTimer = [
//     "00:00",
//     "00:00",
//     "00:00",
//     "00:00",
//     "00:00",
//     "00:00",
//     "00:00",
//     "00:00"
//   ];
//   print("이건가?" + globals.taskList.toString());
// }
