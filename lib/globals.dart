library RouF.globals;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:RouF/component/add_task.dart';

var currentUser = FirebaseAuth.instance.currentUser;
String currentUsername = '';
String currentUid = '';
String friendName = '';
String friendUid = '';

List<String> tasks = ["공부", "운동", "잠자기", "일하기", "놀기", "이동", "밥먹기", "직접 추가"];
//List<AddTask> addTaskList = [];
List<int> taskList = [];
List<List<int>> detailedList = [
  [],
  [],
  [],
  [],
  [],
  [],
  [],
  [],
];
List<int> detailKey = [0, 0, 0, 0, 0, 0, 0, 0];
List<Map<int, String>> details = [];
int statusKey = 7;
// Map<String, String> task_images = {
//   '공부': 'study',
//   '운동': 'exercise',
//   '잠자기': 'sleep',
//   '일하기': 'part-time',
//   '놀기': 'friend',
//   '이동': 'bus',
//   '밥먹기': ''
// };
