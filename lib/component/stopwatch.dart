import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;

int getMilliseconds(String time) {
  int hours = int.parse(time.substring(0, 2));
  int minutes = int.parse(time.substring(4, 6));
  int milliseconds = hours * 60 * 60 * 1000 + minutes * 60 * 1000;
  return milliseconds;
}

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');

  return "${hours}H ${minutes}m";
  //return "$hours:$minutes:$seconds";
}

class StopwatchPage extends StatefulWidget {
  final int index; // 0 1 2 순서대로 index
  final int taskKey; // 얘는 해당 task의 key (공부 0 운동 1 ...)
  final bool play;
  const StopwatchPage(
      {Key? key,
      required this.index,
      required this.taskKey,
      required this.play})
      : super(key: key);
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void handleStartStop(int index, int taskKey) {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      globals.eachtimerStartKey[taskKey] = false;
      setState(() {
        globals.eachTaskTimer[taskKey] = formatTime(
            getMilliseconds(globals.eachTaskTimer[taskKey]) +
                _stopwatch.elapsedMilliseconds);
      });

      _stopwatch = Stopwatch();
      globals.statusKey = 8;
      FirebaseFirestore.instance
          .collection('user')
          .doc(globals.currentUid)
          .update({'statusKey': globals.statusKey});
      FirebaseFirestore.instance
          .collection('user/${globals.currentUid}/tasks')
          .doc(taskKey.toString())
          .update({'time': globals.eachTaskTimer[taskKey]});
    } else {
      _stopwatch.start();
      globals.eachtimerStartKey[taskKey] = false;
      globals.statusKey = taskKey;
      FirebaseFirestore.instance
          .collection('user')
          .doc(globals.currentUid)
          .update({'statusKey': globals.statusKey});
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (globals.eachtimerStartKey[widget.taskKey])
      handleStartStop(widget.index, widget.taskKey);
    if (widget.index == -1 && widget.taskKey == -1) {
      for (int i = 0; i < 8; i++) {
        //StopwatchPage(index: i, taskKey: globals.taskList[i]);
        handleStartStop(i, globals.taskList[i]);
        //print(globals.eachTaskTimer[i]);
      }
      return Container(height: 0, width: 0);
    } else {
      return Container(
        width: 100,
        height: 30,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // IconButton(
              //   onPressed: () {
              //     handleStartStop(widget.index, widget.taskKey);
              //   },
              //   icon:
              //       Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
              //   iconSize: 15,
              // ),

              Text(
                  formatTime(
                      getMilliseconds(globals.eachTaskTimer[widget.taskKey]) +
                          _stopwatch.elapsedMilliseconds),
                  style: TextStyle(fontSize: 15.0)),
            ],
          ),
        ),
      );
    }
  }
}
