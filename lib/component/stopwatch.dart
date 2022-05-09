import 'dart:async';

import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');

  return "$hours:$minutes";
  //return "$hours:$minutes:$seconds";
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'Stopwatch Example', home: StopwatchPage());
//   }
// }

class StopwatchPage extends StatefulWidget {
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

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      //appBar: AppBar(title: Text('Stopwatch Example')),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () {
                print("play button is clicked");
                handleStartStop();
              },
              icon: Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
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
