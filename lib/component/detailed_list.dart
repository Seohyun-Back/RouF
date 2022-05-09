import 'package:flutter/material.dart';
import 'details.dart';
import 'package:RouF/globals.dart' as globals;

class DetailedList extends StatefulWidget {
  final int index;
  const DetailedList({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailedList> createState() => _DetailedListState();
}

class _DetailedListState extends State<DetailedList> {
  @override
  Widget build(BuildContext context) {
    print("detailed_list 호출됨");
    print("globals.detailedList[globals.taskList[widget.index]].length : " +
        globals.detailedList[globals.taskList[widget.index]].length.toString());
    return Container(
      // decoration: BoxDecoration(
      //   color: Color(0xfff4f4f4),
      // ),
      //height: 370,
      //padding: EdgeInsets.symmetric(vertical: 10),
      color: Color(0xfff4f4f4),
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              globals.detailedList[globals.taskList[widget.index]].length,
          itemBuilder: (context, index) {
            if (globals.detailedList[globals.taskList[widget.index]].length ==
                0) {
              print("흠?");
              return SizedBox(
                height: 0,
              );
            } else {
              print(globals.taskList.length);
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
