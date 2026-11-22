import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

import '../../../core/services/file_storage_manager.dart';

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
    final tasksData = await FileStorageManager().loadTasks();

    tasks = tasksData.map((element) => TaskModel.fromJson(element)).toList();
    _loadData();
    _calculatePercentage();

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

    await FileStorageManager().saveTasks(updatedTask);

    _loadTasks();
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
    _loadData();
    _calculatePercentage();

    final updatedTask = tasks.map((element) => element.toJson()).toList();

    await FileStorageManager().saveTasks(updatedTask);

    notifyListeners();
  }

  _calculatePercentage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }

  clear() {
    _loadTasks();
  }
}
