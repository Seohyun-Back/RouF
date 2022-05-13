import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;
import '../component/task.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Future myFuture;

  Future _future() async {
    //globals.taskList = [];
    final _authentication = FirebaseAuth.instance;
    final user = await _authentication.currentUser!;
    //for (int i = 0; i < 8; i++) {
    var taskDocument = await FirebaseFirestore.instance
        .collection('user/${user.uid}/tasks')
        .get()
        .then((value) => {
              value.docs.forEach((document) {
                print("document DATA : ");
                print(document.data());
                globals.taskList.add(document.data()['taskKey']);
                //print(document.data()['time']);
                globals.eachTaskTimer[document.data()['taskKey']] =
                    document.data()['time'];
              })
            });
    for (int i = 0; i < globals.taskList.length; i++) {
      print(globals.taskList[i]);
      print(globals.eachTaskTimer[globals.taskList[i]]);
    }
    return taskDocument;
  }

  @override
  void initState() {
    // assign this variable your Future
    myFuture = _future();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          return Container(
            height: 370,
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: globals.taskList.length,
                itemBuilder: (context, index) {
                  print("globals.taskList.length : " +
                      globals.taskList.length.toString());
                  if (globals.taskList.length == 0) {
                    return Container(
                        child: Text('아래 버튼을 통해 할 일을 추가하고, 루프를 즐겨보세요!',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                color: Colors.black)));
                  } else {
                    return Task(taskNum: index);
                  }
                },
              ),
            ),
          );
        });
  }
}

// Future _future() async {
//   globals.taskList = [];
//   final _authentication = FirebaseAuth.instance;
//   final user = await _authentication.currentUser!;
//   //for (int i = 0; i < 8; i++) {
//   var taskDocument = await FirebaseFirestore.instance
//       .collection('user/${user.uid}/tasks')
//       .get()
//       .then((value) => {
//             value.docs.forEach((document) {
//               print(document.data());
//               globals.taskList.add(document.data()['taskKey']);
//             })
//           });
//   for (int i = 0; i < globals.taskList.length; i++) {
//     print(globals.taskList[i]);
//   }
//   return taskDocument;
// }
