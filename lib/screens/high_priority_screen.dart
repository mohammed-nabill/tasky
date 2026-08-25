import 'dart:convert';

import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final encodedTask = PreferencesManager().getString("tasks");
    if (encodedTask != null) {
      final taskAfterDecode = jsonDecode(encodedTask) as List<dynamic>;

      setState(() {
        highPriorityTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.highPriority)
            .toList();
      });
    }
  }

  void _deleteTask(int id) {
    final encodedTask = PreferencesManager().getString("tasks");
    if (encodedTask != null) {
      final taskAfterDecode = jsonDecode(encodedTask) as List<dynamic>;
      final List<TaskModel> tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((task) => task.id == id);
      setState(() {
        highPriorityTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      PreferencesManager().setString("tasks", jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskListWidget(
          emptyMassage: "No Task Found",
          tasks: highPriorityTasks,
          onTap: (bool? value, int? index) async {
            setState(() {
              highPriorityTasks[index!].isDone =
                  !highPriorityTasks[index].isDone;
            });

            final allData = PreferencesManager().getString("tasks");
            if (allData != null) {
              List<TaskModel> allDataList = (jsonDecode(allData) as List)
                  .map((toElement) => TaskModel.fromJson(toElement))
                  .toList();
              final int newIndex = allDataList.indexWhere(
                (e) => e.id == highPriorityTasks[index!].id,
              );
              allDataList[newIndex] = highPriorityTasks[index!];

              PreferencesManager().setString("tasks", jsonEncode(allDataList));
              _loadTasks();
            }
          },
          onDelete: (int id) => _deleteTask(id),
          onEdit: () => _loadTasks(),
        ),
      ),
    );
  }
}
