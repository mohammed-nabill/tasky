import 'package:flutter/material.dart';

import '../../core/services/hive_storage_manager.dart';
import '../../models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final TextEditingController taskName = TextEditingController();

  final TextEditingController taskDescription = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  bool highPriority = true;

  Future<void> addTask(BuildContext context) async {
    if (form.currentState!.validate()) {
      final List<TaskModel> tasks = HiveStorageManager().loadTasks();

      final TaskModel model = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch,
        taskName: taskName.text,
        taskDescription: taskDescription.text,
        highPriority: highPriority,
      );
      tasks.add(model);
      await HiveStorageManager().saveTasks(tasks);
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    highPriority = value;
    notifyListeners();
  }
}
