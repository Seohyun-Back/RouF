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
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 5, 17),
              width: 300,
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
                          height: 25,
                          width: 25,
                        ),
                        // backgroundImage: AssetImage(
                        //     'assets/images/TaskIcon/${globals.tasks[globals.taskList[widget.taskNum]]}.png'),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 50,
                        child: Text(
                          globals.tasks[globals.taskList[widget.taskNum]],
                          style: TextStyle(fontSize: 15),
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
                      StopwatchPage(),
                      IconButton(
                        alignment: Alignment.topRight,
                        onPressed: () {
                          print("task add button is clicked");
                          setState(() {
                            globals
                                .detailedList[globals.taskList[widget.taskNum]]
                                .add(globals.detailKey[widget.taskNum]++);
                          });
                        },
                        icon: Icon(Icons.add),
                        iconSize: 17,
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
