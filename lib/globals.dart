library RouF.globals;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class Todo {
  final int id; //todo마다의 고유한 ID
  final String todo; //내가 해야할것
  bool checked; //해당 todo를 완료 했는지 않았는지 확인하기 위한 용도

  Todo({
    required this.id,
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

List<String> tasks = ["공부", "운동", "잠자기", "일하기", "놀기", "이동", "밥먹기", "기타", "숨쉬기"];
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
List<int> eachTaskKey = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
]; // 각 todo의 갯수..? 인덱스로 쓰려고 만들었던듯
List<String> eachTaskTimer = [
  "00H 00m",
  "00H 00m",
  "00H 00m",
  "00H 00m",
  "00H 00m",
  "00H 00m",
  "00H 00m",
  "00H 00m"
];
List<bool> eachtimerStartKey = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];
int statusKey = 8; // 기본 숨쉬기 상태
int actionKey = 8;
List<String> action = [
  "공부하는 중..",
  "운동하는 중..",
  "잠자는 중..",
  "일하는 중..",
  "노는 중..",
  "이동하는 중..",
  "밥 먹는 중..",
  "다른 거 하는 중..",
  "숨 쉬는 중.."
];

void initGlobals() {
  statusKey = 8;
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
  eachTaskTimer = [
    "00H 00m",
    "00H 00m",
    "00H 00m",
    "00H 00m",
    "00H 00m",
    "00H 00m",
    "00H 00m",
    "00H 00m"
  ];
}
