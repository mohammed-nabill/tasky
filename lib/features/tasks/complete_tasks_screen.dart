import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/components/task_list_widget.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';
import '../../models/task_model.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModel> completeTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final encodedTask = PreferencesManager().getString(StorageKey.tasks);
    if (encodedTask != null) {
      final taskAfterDecode = jsonDecode(encodedTask) as List<dynamic>;

      setState(() {
        completeTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone)
            .toList();
      });
    }
  }

  void _deleteTask(int id) {
    final encodedTask = PreferencesManager().getString(StorageKey.tasks);
    if (encodedTask != null) {
      final taskAfterDecode = jsonDecode(encodedTask) as List<dynamic>;
      final List<TaskModel> tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((task) => task.id == id);
      setState(() {
        completeTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TaskListWidget(
              emptyMassage: "No Task Found",
              tasks: completeTasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  completeTasks[index!].isDone = !completeTasks[index].isDone;
                });

                final allData = PreferencesManager().getString(
                  StorageKey.tasks,
                );
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((toElement) => TaskModel.fromJson(toElement))
                      .toList();
                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == completeTasks[index!].id,
                  );
                  allDataList[newIndex] = completeTasks[index!];
                  PreferencesManager().setString(
                    StorageKey.tasks,
                    jsonEncode(allDataList),
                  );
                  _loadTasks();
                }
              },
              onDelete: (int id) => _deleteTask(id),
              onEdit: () => _loadTasks(),
            ),
          ),
        ),
      ],
    );
  }
}
