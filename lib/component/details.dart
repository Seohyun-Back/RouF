import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;

class Details extends StatefulWidget {
  final int taskIndex;
  final int detailedIndex;
  const Details(
      {Key? key, required this.taskIndex, required this.detailedIndex})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    print("detials 호출됨");
    return Container(
        // decoration: BoxDecoration(
        //   color: Color(0xfff4f4f4),
        // ),
        child: Row(
      children: [
        // Container(
        //   child: Text(globals.detailedList[widget.taskIndex]
        //               [widget.detailedIndex]
        //           .toString() +
        //       "  "),
        // ),
        Container(
          height: 40,
          width: 240,
          child: TextFormField(
            style: TextStyle(
              fontSize: 12,
            ),
            decoration: InputDecoration(
              fillColor: Color(0xfff4f4f4),
              //contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              hintText: "입력하세요",
            ),
          ),
        )
      ],
    ));
  }
}
