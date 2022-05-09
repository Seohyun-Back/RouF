import 'package:flutter/material.dart';
import 'detailed_list.dart';
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
    //return Container(child: Text(globals.taskList[widget.taskNum].toString()));
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
                          // backgroundImage: AssetImage(
                          //     'assets/images/TaskIcon/${globals.tasks[globals.taskList[widget.taskNum]]}.png'),
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
                                    // setState(() {
                                    //   globals
                                    //       .detailedList[globals.taskList[widget.taskNum]]
                                    //       .add(globals.detailKey[
                                    //           globals.taskList[widget.taskNum]]++);
                                    // });
                                    // print("ddddd : " +
                                    //     globals.detailedList[
                                    //             globals.taskList[widget.taskNum]]
                                    //         .toString());
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
                              // IconButton(
                              //     icon: Icon(Icons.clear_sharp, size: 15),
                              //     visualDensity: VisualDensity(
                              //       horizontal: -4.0,
                              //     ),
                              //     onPressed: () {
                              //       setState(() {
                              //         print("삭제 전");
                              //         for (int i = 0;
                              //             i < globals.taskList.length;
                              //             i++) {
                              //           print(
                              //               globals.taskList.length.toString() +
                              //                   ":" +
                              //                   globals.taskList[i].toString());
                              //         }
                              //         globals.taskList.removeAt(widget.taskNum);
                              //         print("삭제 후");
                              //         for (int i = 0;
                              //             i < globals.taskList.length;
                              //             i++) {
                              //           print(widget.taskNum.toString() +
                              //               ":" +
                              //               globals.taskList[i].toString());
                              //         }
                              //       });
                              //     })
                            ],
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     print("play button is clicked");

                        //   },
                        //   icon: Icon(Icons.play_arrow),
                        //   iconSize: 17,
                        // ),
                        //SizedBox(width: 50), // timer

                        StopwatchPage(
                          index: widget.taskNum,
                          taskKey: globals.taskList[widget.taskNum],
                        ),
                      ],
                    ),
                    DetailedList(index: widget.taskNum),
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
