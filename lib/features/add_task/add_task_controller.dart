import 'package:flutter/material.dart';

import '../../core/services/file_storage_manager.dart';
import '../../models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final TextEditingController taskName = TextEditingController();

  final TextEditingController taskDescription = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  bool highPriority = true;

  Future<void> addTask(BuildContext context) async {
    if (form.currentState!.validate()) {
      final List tasks = await FileStorageManager().loadTasks();

      final TaskModel model = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch,
        taskName: taskName.text,
        taskDescription: taskDescription.text,
        highPriority: highPriority,
      );
      tasks.add(model.toJson());
      await FileStorageManager().saveTasks(tasks);
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    highPriority = value;
    notifyListeners();
  }
}
