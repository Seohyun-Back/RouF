//import 'dart:html';

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
  late int selectedIndex = -1;
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
    // for (int i = 0; i < globals.taskList.length; i++) {
    //   print(globals.taskList[i]);
    //   print(globals.eachTaskTimer[globals.taskList[i]]);
    // }
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
              height: MediaQuery.of(context).size.height * 0.45,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: globals.taskList.length != 0
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: globals.taskList.length,
                        itemBuilder: (context, index) {
                          print("빰빰");
                          print(globals.taskList.length);
                          //print("globals.taskList.length : " +
                          //    globals.taskList.length.toString());
                          if (globals.taskList.length == 0) {
                            return SizedBox(
                              height: 0,
                            );
                          } else {
                            return Dismissible(
                              key: Key(globals.taskList[index].toString()),
                              child: ListTile(
                                onTap: () {
                                  if (selectedIndex != index &&
                                      globals.statusKey != 8) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("먼저 실행중인 카테고리를 종료해주세요."),
                                    ));
                                  } else {
                                    globals.eachtimerStartKey[
                                        globals.taskList[index]] = true;
                                    setState(() {
                                      selectedIndex == index
                                          ? selectedIndex = -1
                                          : selectedIndex = index;
                                    });
                                  }
                                },
                                title: Task(
                                  taskNum: index,
                                  selected: selectedIndex == index,
                                ),
                              ),
                              background: Container(color: Colors.white),
                              confirmDismiss: (direction) {
                                //if(direction == DismissDirection.endToStart){
                                return showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                          //title: const Text(""),
                                          content: Text("카테고리를 삭제하시겠습니까?"),
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
                                    });
                              },
                              onDismissed: (direction) {
                                setState(() {
                                  globals.todos[globals.taskList[index]]
                                      .clear();
                                  globals.eachTaskKey[globals.taskList[index]] =
                                      0;
                                  globals.eachTaskTimer[
                                      globals.taskList[index]] = "00H 00m";
                                  if (globals.statusKey ==
                                      globals.taskList[index]) {
                                    globals.statusKey = 8;
                                  }

                                  FirebaseFirestore.instance
                                      .collection(
                                          'user/${globals.currentUid}/tasks/${globals.taskList[index]}/todos')
                                      .get()
                                      .then((snapshot) {
                                    for (DocumentSnapshot ds in snapshot.docs) {
                                      ds.reference.delete();
                                    }
                                  });

                                  FirebaseFirestore.instance
                                      .collection(
                                          "user/${globals.currentUid}/tasks")
                                      .doc(globals.taskList[index].toString())
                                      .delete();

                                  globals.taskList.removeAt(index);
                                });
                              },
                            );
                          }
                        },
                      ),
                    )
                  : Container(
                      height: 300,
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: Text('아래 버튼을 통해 태스크를 추가하고 루프를 즐겨보세요!',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ));
        });
  }
}
