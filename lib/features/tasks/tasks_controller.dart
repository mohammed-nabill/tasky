import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class TasksController with ChangeNotifier {
  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completeTasks = [];

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
      todoTasks = tasks.where((element) => element.isDone == false).toList();
      completeTasks = tasks.where((element) => element.isDone).toList();
    }
    notifyListeners();
  }

  void deleteTask(int id) {
    tasks.removeWhere((task) => task.id == id);
    todoTasks.removeWhere((task) => task.id == id);
    completeTasks.removeWhere((task) => task.id == id);
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = !todoTasks[index].isDone;
    final int newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  void doneCompleteTask(bool? value, int? index) async {
    if (index == null) return;
    completeTasks[index].isDone = !completeTasks[index].isDone;
    final int newIndex = tasks.indexWhere(
      (e) => e.id == completeTasks[index].id,
    );
    tasks[newIndex] = completeTasks[index];
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }
}
