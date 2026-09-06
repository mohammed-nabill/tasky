import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

import '../../../core/constants/storage_key.dart';
import '../../../core/services/preferences_manager.dart';

class TasksController with ChangeNotifier {
  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> highPriorityTasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percentage = 0;

  void init() {
    _loadTasks();
  }

  void _loadTasks() async {
    final encodedTask = PreferencesManager().getString(StorageKey.tasks);
    if (encodedTask != null) {
      final taskAfterDecode = jsonDecode(encodedTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      _loadData();
      _calculatePercentage();
    }
    notifyListeners();
  }

  void _loadData() {
    todoTasks = tasks.where((element) => element.isDone == false).toList();
    completeTasks = tasks.where((element) => element.isDone).toList();
    highPriorityTasks = tasks.where((element) => element.highPriority).toList();
    highPriorityTasks = highPriorityTasks.reversed.toList();
  }

  doneTask(bool? value, int? id) async {
    final int index = tasks.indexWhere((element) => element.id == id);
    tasks[index].isDone = !tasks[index].isDone;
    _loadData();
    _calculatePercentage();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    _loadTasks();
  }

  void deleteTask(int id) {
    tasks.removeWhere((task) => task.id == id);
    _loadData();
    _calculatePercentage();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }

  _calculatePercentage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }
}
