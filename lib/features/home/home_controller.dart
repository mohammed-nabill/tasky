import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';
import '../../models/task_model.dart';

class HomeController with ChangeNotifier {
  String? name;
  String? userImage;
  List<TaskModel> tasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percentage = 0;

  void init() {
    getUserData();
    loadTasks();
  }

  void loadTasks() async {
    final encodedTask = PreferencesManager().getString(StorageKey.tasks);
    if (encodedTask != null) {
      final taskAfterDecode = jsonDecode(encodedTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      calculatePercentage();
    }
    notifyListeners();
  }

  void deleteTask(int id) {
    tasks.removeWhere((task) => task.id == id);
    calculatePercentage();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }

  void getUserData() async {
    name = PreferencesManager().getString(StorageKey.userName);
    userImage = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }

  calculatePercentage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }

  doneTask(bool? value, int? index) async {
    tasks[index!].isDone = !tasks[index].isDone;
    calculatePercentage();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }
}
