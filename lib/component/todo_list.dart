import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RouF/globals.dart' as globals;

class TodoList extends StatefulWidget {
  final int index;
  const TodoList({Key? key, required this.index}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    //bool done = false;

    return Container(
      color: Color(0xfff4f4f4),
      child: IgnorePointer(
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
                    onChanged: (newValue) async {
                      await FirebaseFirestore.instance
                          .collection(
                              'user/${globals.currentUid}/tasks/${globals.taskList[widget.index]}/todos')
                          .doc(globals
                              .todos[globals.taskList[widget.index]][index]
                              .todo)
                          // .doc(globals
                          //     .eachTaskKey[globals.taskList[widget.index]]
                          //     .toString())
                          .set({
                        globals.todos[globals.taskList[widget.index]][index]
                            .todo: newValue
                      });

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
                        FirebaseFirestore.instance
                            .collection(
                                'user/${globals.currentUid}/tasks/${globals.taskList[widget.index]}/todos')
                            .doc(globals
                                .todos[globals.taskList[widget.index]][index]
                                .todo)
                            .delete();
                        globals.eachTaskKey[globals.taskList[widget.index]]--;
                        setState(() {
                          globals.todos[globals.taskList[widget.index]]
                              .removeAt(index);
                        });
                      }));
            }
          },
        ),
      ),
    );
  }
}
