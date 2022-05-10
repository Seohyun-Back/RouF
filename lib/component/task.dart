import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'todo_list.dart';
import 'stopwatch.dart';
import 'package:RouF/globals.dart' as globals;

class Task extends StatefulWidget {
  final int taskNum;
  const Task({Key? key, required this.taskNum}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    if (globals.taskList.length == 0) {
      return SizedBox(
        height: 10,
      );
    } else {
      return Container(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 17),
                width: 330,
                //height: 150,
                decoration: BoxDecoration(
                    color: Color(0xfff4f4f4),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                        bottomLeft: const Radius.circular(20.0),
                        bottomRight: const Radius.circular(20.0))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xff95DF7D),
                          child: Image.asset(
                            'assets/images/TaskIcon/${globals.tasks[globals.taskList[widget.taskNum]]}.png',
                            height: 23,
                            width: 23,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 130,
                          child: Row(
                            children: [
                              Text(
                                globals.tasks[globals.taskList[widget.taskNum]],
                                style: TextStyle(fontSize: 15),
                              ),
                              IconButton(
                                  // alignment: Alignment.topRight,
                                  onPressed: () {
                                    print("task add button is clicked");
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("Add Todo"),
                                            content: TextField(
                                              onChanged: (String value) {
                                                globals.input = value;
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'user/${globals.currentUid}/tasks/${globals.taskList[widget.taskNum]}/todos')
                                                        .doc(globals.input)
                                                        .set({
                                                      globals.input: false
                                                    });
                                                    setState(() {
                                                      globals.Todo todo =
                                                          globals.Todo(
                                                              id: widget
                                                                  .taskNum,
                                                              todo:
                                                                  globals.input,
                                                              checked: false);
                                                      globals.todos[globals
                                                                  .taskList[
                                                              widget.taskNum]]
                                                          .add(todo);
                                                    });
                                                    Navigator.of(context)
                                                        .pop(); // input 입력 후 창 닫히도록
                                                  },
                                                  child: Text("추가"))
                                            ]);
                                      },
                                    );
                                  },
                                  visualDensity:
                                      VisualDensity(horizontal: -4.0),
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 15,
                                  )),
                            ],
                          ),
                        ),
                        StopwatchPage(
                          index: widget.taskNum,
                          taskKey: globals.taskList[widget.taskNum],
                        ),
                      ],
                    ),
                    TodoList(index: widget.taskNum),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }
  }
}
