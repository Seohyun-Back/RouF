import 'package:flutter/material.dart';
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
    //bool done = false;

    return Container(
      color: Color(0xfff4f4f4),
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: globals.todos[globals.taskList[widget.index]].length,
          itemBuilder: (context, index) {
            if (globals.taskList[widget.index] == -1)
              return Container(
                height: 0,
              );
            else {
              return ListTile(
                  leading: Checkbox(
                    value: globals
                        .todos[globals.taskList[widget.index]][index].checked,
                    onChanged: (newValue) {
                      setState(() {
                        globals.todos[globals.taskList[widget.index]][index]
                            .checked = newValue!;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  dense: true,
                  title: Text(
                      globals.todos[globals.taskList[widget.index]][index].todo,
                      style: TextStyle(fontSize: 13)),
                  trailing: IconButton(
                      icon: Icon(Icons.clear_sharp, size: 13),
                      onPressed: () {
                        setState(() {
                          globals.todos[globals.taskList[widget.index]]
                              .removeAt(index);
                        });
                      }));
            }

            //child: Text(globals.todos[globals.taskList[widget.index]][index]),

            // if (globals.todos[globals.taskList[widget.index]].length == 0) {
            //   print("흠?");
            //   return SizedBox(
            //     height: 0,
            //   );
            // } else {
            //   //print(globals.taskList.length);
            //   //return Details(taskNum: index);
            //   return Details(
            //     taskIndex: widget.index,
            //     detailedIndex: index,
            //   );
            // }
          },
        ),
      ),
    );
  }
}
