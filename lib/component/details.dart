import 'package:flutter/material.dart';
import 'package:gw/globals.dart' as globals;

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
    return Container(
        decoration: BoxDecoration(
          color: Color(0xfff4f4f4),
        ),
        child: Row(
          children: [
            Text(globals.detailedList[widget.taskIndex][widget.detailedIndex]
                .toString()),
            TextFormField(
              decoration: InputDecoration(hintText: "입력하세요"),
            )
          ],
        ));
  }
}
