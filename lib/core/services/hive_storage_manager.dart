import 'package:hive_ce_flutter/adapters.dart';
import 'package:tasky/models/task_model.dart';

import '../constants/hive_constants.dart';

class HiveStorageManager {
  static final HiveStorageManager _instance = HiveStorageManager._();

  HiveStorageManager._();

  factory HiveStorageManager() {
    return _instance;
  }

  late Box<TaskModel> _taskBox;

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    _taskBox = await Hive.openBox<TaskModel>(HiveConstants.tasksNameCollection);
  }

  saveTasks(List<TaskModel> list) async {
    await _taskBox.clear();
    await _taskBox.addAll(list);
  }

  List<TaskModel> loadTasks() {
    return _taskBox.values.toList();
  }

  Future<void> clear() async {
    await _taskBox.clear();
  }
}
