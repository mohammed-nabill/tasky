import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';
import '../../models/task_model.dart';

class AddTaskController with ChangeNotifier {

  final TextEditingController taskName = TextEditingController();

  final TextEditingController taskDescription = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  bool highPriority = true;

  Future<void> addTask(BuildContext context) async {
    if (form.currentState!.validate()) {
      final taskJson = PreferencesManager().getString(
        StorageKey.tasks,
      );
      List listTasks = [];
      if (taskJson != null) {
        listTasks = jsonDecode(taskJson);
      }
      final TaskModel model = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch,
        taskName: taskName.text,
        taskDescription: taskDescription.text,
        highPriority: highPriority,
      );
      listTasks.add(model.toJson());

      final taskEncode = jsonEncode(listTasks);
      await PreferencesManager().setString(
        StorageKey.tasks,
        taskEncode,
      );
      Navigator.of(context).pop(true);
    }
  }
  void toggle(bool value){
highPriority = value;
notifyListeners();
  }
}