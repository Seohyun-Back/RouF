library RouF.globals;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:RouF/component/add_task.dart';

class Todo {
  //final int id; //todo마다의 고유한 ID
  final String todo; //내가 해야할것
  bool checked; //해당 todo를 완료 했는지 않았는지 확인하기 위한 용도

  Todo({
    //required this.id,
    required this.todo,
    required this.checked,
  });
}

var currentUser = FirebaseAuth.instance.currentUser;
String currentUsername = '';
String currentUid = '';
String currentEmail = '';
String friendName = '';
String friendUid = '';
String friendEmail = '';
int friendNum = 0;

List<String> tasks = ["공부", "운동", "잠자기", "일하기", "놀기", "이동", "밥먹기", "기타"];
//List<AddTask> addTaskList = [];
List<List<Todo>> todos = [
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
];
String input = '';
List<int> taskList = [];
List<int> eachTaskKey = [0, 0, 0, 0, 0, 0, 0, 0];
List<String> eachTaskTimer = ["", "", "", "", "", "", "", ""];

int statusKey = 8; // 기본 숨쉬기 상태

void initGlobals() {
  currentUsername = '';
  currentUid = '';
  currentEmail = '';
  friendUid = '';
  friendName = '';
  friendEmail = '';
  friendNum = 0;
  todos = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  input = '';
  taskList = [];
  eachTaskKey = [0, 0, 0, 0, 0, 0, 0, 0];
  eachTaskTimer = ["", "", "", "", "", "", "", ""];
}
