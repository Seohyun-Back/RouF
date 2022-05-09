import 'dart:async';

import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');

  return "$hours:$minutes";
  //return "$hours:$minutes:$seconds";
}

class StopwatchPage extends StatefulWidget {
  final int index; // 0 1 2 순서대로 그저 index
  final int taskKey; // 얘는 해당 task의 key (공부 0 운동 1 ...)
  const StopwatchPage({Key? key, required this.index, required this.taskKey})
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
      globals.eachTaskTimer[index] = formatTime(_stopwatch.elapsedMilliseconds);
    } else {
      _stopwatch.start();
      globals.statusKey = taskKey;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == -1 && widget.taskKey == -1) {
      for (int i = 0; i < 8; i++) {
        //StopwatchPage(index: i, taskKey: globals.taskList[i]);
        handleStartStop(i, globals.taskList[i]);
        print(globals.eachTaskTimer[i]);
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
              IconButton(
                onPressed: () {
                  print("play button is clicked");
                  print("기존 statusKey : " + globals.statusKey.toString());
                  handleStartStop(widget.index, widget.taskKey);
                  // _stopwatch.isRunning
                  //     ? globals.statusKey = widget.taskKey
                  //     : globals.eachTaskTimer[widget.index] =
                  //         formatTime(_stopwatch.elapsedMilliseconds);
                  print("변경된 statusKey : " + globals.statusKey.toString());
                  print("저장된 시간 : " + globals.eachTaskTimer[widget.index]);
                },
                icon:
                    Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
                iconSize: 15,
              ),
              Text(formatTime(_stopwatch.elapsedMilliseconds),
                  style: TextStyle(fontSize: 15.0)),
              // ElevatedButton(
              //     onPressed: handleStartStop,
              //     child: Text(_stopwatch.isRunning ? 'Stop' : 'Start')),
            ],
          ),
        ),
      );
    }
  }
}
