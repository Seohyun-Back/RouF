import 'package:flutter/material.dart';
import 'package:gw/globals.dart' as globals;
import '../component/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: globals.taskList.length,
          itemBuilder: (context, index) {
            if (globals.taskList.length == 0) {
              return SizedBox(
                height: 10,
              );
            } else {
              print(globals.taskList.length);
              return Task(taskNum: index);
              // return Column(
              //   children: [
              //     Align(
              //       alignment: Alignment.centerLeft,
              //       child: Text(globals.taskList[index].toString()),
              //     ),
              //     Align(
              //       alignment: Alignment.center,
              //       child: Padding(
              //           padding: const EdgeInsets.only(right: 8.0),
              //           child: Text(
              //               globals.tasks[globals.taskList[index]].toString())),
              //     ),
              //   ],
              // );
            }
            // } else {
            //   //print(globals.taskList.length);
            //   return SizedBox(height: 10);

            //   //return Text("이건뭐야 ; ");
            //   //return EventItem(event: timedEvents[index - 1]);
            // }
          },
        ),
      ),
    );
  }
}
