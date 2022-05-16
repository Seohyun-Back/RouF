import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'todo_list.dart';
import 'stopwatch.dart';
import 'package:RouF/globals.dart' as globals;

class Task extends StatefulWidget {
  final int taskNum;
  final bool selected;
  const Task({Key? key, required this.taskNum, required this.selected})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    if (globals.taskList.length == 0) {
      return Container(
        child: Text('아래 버튼을 통해 할 일을 추가하고, 루프를 즐겨보세요!',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w200,
                color: Colors.black)),
      );
    } else {
      print(widget.taskNum.toString() +
          "selected : " +
          widget.selected.toString());
      return Container(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 17),
                width: 330,
                //height: 150,

                decoration: BoxDecoration(
                  color: widget.selected == true
                      ? Color(0xffD6D6D6)
                      : Color(0xfff4f4f4),
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(20.0)),
                ),
                // decoration:
                //     globals.taskList[widget.taskNum] == globals.statusKey
                //         ? BoxDecoration(
                //             color: Color(0xfff4f4f4),
                //             borderRadius: new BorderRadius.only(
                //                 topLeft: const Radius.circular(20.0),
                //                 topRight: const Radius.circular(20.0),
                //                 bottomLeft: const Radius.circular(20.0),
                //                 bottomRight: const Radius.circular(20.0)),
                //             boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.lightGreen,
                //                   offset: Offset(4.0, 4.0),
                //                   blurRadius: 15.0,
                //                   spreadRadius: 1.0,
                //                 )
                //               ])
                //         : BoxDecoration(
                //             color: Color(0xfff4f4f4),
                //             borderRadius: new BorderRadius.only(
                //                 topLeft: const Radius.circular(20.0),
                //                 topRight: const Radius.circular(20.0),
                //                 bottomLeft: const Radius.circular(20.0),
                //                 bottomRight: const Radius.circular(20.0)),
                //           ),

                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xffb5d096),
                          child: Image.asset(
                            'assets/images/TaskIcon/${globals.tasks[globals.taskList[widget.taskNum]]}.png',
                            height: 23,
                            width: 23,
                          ),
                        ),
                        SizedBox(width: 18),
                        Container(
                          width: 130,
                          child: Row(
                            children: [
                              Text(
                                globals.tasks[globals.taskList[widget.taskNum]],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                  // alignment: Alignment.topRight,
                                  onPressed: () {
                                    //print("task add button is clicked");
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("투두리스트 추가"),
                                            content: TextField(
                                              onChanged: (String value) {
                                                globals.input = value;
                                              },
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      globals.Todo todo =
                                                          globals.Todo(
                                                              id: globals
                                                                  .eachTaskKey[globals
                                                                      .taskList[
                                                                  widget
                                                                      .taskNum]],
                                                              todo:
                                                                  globals.input,
                                                              checked: false);
                                                      globals.todos[globals
                                                                  .taskList[
                                                              widget.taskNum]]
                                                          .add(todo);

                                                      print(globals.eachTaskKey[
                                                          globals.taskList[
                                                              widget.taskNum]]);
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'user/${globals.currentUid}/tasks/${globals.taskList[widget.taskNum]}/todos')
                                                        .doc('${globals.todos[globals.taskList[widget.taskNum]][globals.eachTaskKey[globals.taskList[widget.taskNum]]].id}' +
                                                            '${globals.todos[globals.taskList[widget.taskNum]][globals.eachTaskKey[globals.taskList[widget.taskNum]]].todo}')
                                                        .set({
                                                      // globals.input: globals
                                                      //     .todos[globals
                                                      //             .taskList[
                                                      //         widget
                                                      //             .taskNum]][globals
                                                      //         .eachTaskKey[globals
                                                      //             .taskList[
                                                      //         widget.taskNum]]]
                                                      //     .checked
                                                      'id': globals
                                                          .todos[globals
                                                                  .taskList[
                                                              widget
                                                                  .taskNum]][globals
                                                              .eachTaskKey[globals
                                                                  .taskList[
                                                              widget.taskNum]]]
                                                          .id,
                                                      'todo': globals
                                                          .todos[globals
                                                                  .taskList[
                                                              widget
                                                                  .taskNum]][globals
                                                              .eachTaskKey[globals
                                                                  .taskList[
                                                              widget.taskNum]]]
                                                          .todo,
                                                      'checked': globals
                                                          .todos[globals
                                                                  .taskList[
                                                              widget
                                                                  .taskNum]][globals
                                                              .eachTaskKey[globals
                                                                  .taskList[
                                                              widget.taskNum]]]
                                                          .checked
                                                    });
                                                    globals.eachTaskKey[
                                                        globals.taskList[
                                                            widget.taskNum]]++;
                                                    globals.input = '';
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
                                    Icons.add_task_rounded,
                                    size: 15,
                                  )),
                            ],
                          ),
                        ),
                        StopwatchPage(
                          index: widget.taskNum,
                          taskKey: globals.taskList[widget.taskNum],
                          play: widget.selected,
                        ),
                      ],
                    ),
                    TodoList(
                      index: widget.taskNum,
                      selected: widget.selected,
                    ),
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
