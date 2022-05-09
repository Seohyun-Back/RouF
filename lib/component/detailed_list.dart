import 'package:flutter/material.dart';
import 'details.dart';
import 'package:gw/globals.dart' as globals;

class DetailedList extends StatefulWidget {
  final int index;
  const DetailedList({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailedList> createState() => _DetailedListState();
}

class _DetailedListState extends State<DetailedList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Color(0xfff4f4f4),
      // ),
      //height: 370,
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: globals.detailedList[widget.index].length,
          itemBuilder: (context, index) {
            if (globals.detailedList[widget.index].length == 0) {
              return SizedBox(
                height: 0,
              );
            } else {
              //print(globals.taskList.length);
              //return Details(taskNum: index);
              return Details(
                taskIndex: widget.index,
                detailedIndex: index,
              );
            }
          },
        ),
      ),
    );
  }
}
