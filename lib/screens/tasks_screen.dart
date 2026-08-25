import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/widgets/task_list_widget.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> todoTasks = [];

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
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone == false)
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
        todoTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      PreferencesManager().setString("tasks", jsonEncode(updatedTask));
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
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TaskListWidget(
              emptyMassage: "No Task Found",
              tasks: todoTasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  todoTasks[index!].isDone = !todoTasks[index].isDone;
                });

                final allData = PreferencesManager().getString("tasks");
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((toElement) => TaskModel.fromJson(toElement))
                      .toList();
                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == todoTasks[index!].id,
                  );
                  allDataList[newIndex] = todoTasks[index!];

                  PreferencesManager().setString(
                    "tasks",
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
