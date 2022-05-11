import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;

class TodoList extends StatefulWidget {
  final int index;
  const TodoList({Key? key, required this.index}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Future todoFuture;
  late Future countDocuments;

  Future _countDocuments() async {
    final _authentication = FirebaseAuth.instance;
    final user = await _authentication.currentUser!;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection(
            'user/${user.uid}/tasks/${globals.taskList[widget.index]}/todos')
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    print(_myDocCount.length); // Count of Documents in Collection
    globals.eachTaskKey[globals.taskList[widget.index]] = _myDocCount.length;
    return _myDocCount.length;
  }

  Future _todofuture() async {
    final _authentication = FirebaseAuth.instance;
    final user = await _authentication.currentUser!;
    _countDocuments();
    print("eachTaskKey : ");
    print(globals.eachTaskKey);
    if (globals.taskList.length == 0) {
      return 'NULL';
    } else {
      print('user/${user.uid}/tasks/${globals.taskList[widget.index]}');
      //globals.todos[0][0] = new globals.Todo(id: 1, todo: "aa", checked: false);
      var todoDocument = await FirebaseFirestore.instance
          .collection(
              'user/${user.uid}/tasks/${globals.taskList[widget.index]}/todos')
          .get()
          .then((value) => {
                value.docs.forEach((document) {
                  print("document DATA : ");
                  print(document.data());

                  globals.todos[globals.taskList[widget.index]].add(
                      new globals.Todo(
                          id: document.data()['id'],
                          todo: document.data()['todo'],
                          checked: document.data()['checked']));

                  // globals.todos[globals.taskList[widget.index]]
                  //         [document.data()['id']] =
                  //     new globals.Todo(
                  //         id: document.data()['id'],
                  //         todo: document.data()['todo'],
                  //         checked: document.data()['checked']);
                  // globals.taskList.add(document.data()['taskKey']);
                  // //print(document.data()['time']);
                  // globals.eachTaskTimer[document.data()['taskKey']] =
                  //     document.data()['time'];
                })
              });
      return todoDocument;
    }

    // for (int i = 0; i < globals.taskList.length; i++) {
    //   print(globals.taskList[i]);
    //   print(globals.eachTaskTimer[globals.taskList[i]]);
    // }
  }

  @override
  void initState() {
    // assign this variable your Future
    todoFuture = _todofuture();
    countDocuments = _countDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //bool done = false;

    return FutureBuilder(
        future: todoFuture,
        builder: (context, snapshot) {
          return Container(
            color: Color(0xfff4f4f4),
            //child: IgnorePointer(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: globals.todos[globals.taskList[widget.index]].length,
              itemBuilder: (context, index) {
                if (globals.taskList[widget.index] == -1)
                  return Container(
                    height: 0,
                  );
                else {
                  return ListTile(
                      leading: Checkbox(
                        value: globals
                            .todos[globals.taskList[widget.index]][index]
                            .checked,
                        onChanged: (newValue) async {
                          await FirebaseFirestore.instance
                              .collection(
                                  'user/${globals.currentUid}/tasks/${globals.taskList[widget.index]}/todos')
                              .doc('${globals.todos[globals.taskList[widget.index]][index].id}' +
                                  '${globals.todos[globals.taskList[widget.index]][index].todo}')
                              // .doc(globals
                              //     .eachTaskKey[globals.taskList[widget.index]]
                              //     .toString())
                              .set({
                            'id': globals
                                .todos[globals.taskList[widget.index]][
                                    globals.eachTaskKey[
                                        globals.taskList[widget.index] - 1]]
                                .id,
                            'todo': globals
                                .todos[globals.taskList[widget.index]][
                                    globals.eachTaskKey[
                                        globals.taskList[widget.index] - 1]]
                                .todo,
                            'checked': newValue
                          });

                          setState(() {
                            globals.todos[globals.taskList[widget.index]][index]
                                .checked = newValue!;
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      dense: true,
                      title: Text(
                          globals.todos[globals.taskList[widget.index]][index]
                              .todo,
                          style: TextStyle(fontSize: 13)),
                      trailing: IconButton(
                          icon: Icon(Icons.clear_sharp, size: 13),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection(
                                    'user/${globals.currentUid}/tasks/${globals.taskList[widget.index]}/todos')
                                .doc('${globals.todos[globals.taskList[widget.index]][index].id}' +
                                    '${globals.todos[globals.taskList[widget.index]][index].todo}')
                                .delete();
                            globals
                                .eachTaskKey[globals.taskList[widget.index]]--;
                            setState(() {
                              globals.todos[globals.taskList[widget.index]]
                                  .removeAt(index);
                            });
                          }));
                }
              },
            ),
            //),
          );
        });
  }
}
