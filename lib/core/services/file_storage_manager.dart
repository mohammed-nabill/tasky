import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final FileStorageManager _instance = FileStorageManager._();

  FileStorageManager._();

  factory FileStorageManager() {
    return _instance;
  }

  late final Directory _appDocumentsDir;
  late final File _tasksFile;

  init() async {
    _appDocumentsDir = await getApplicationDocumentsDirectory();
    _tasksFile = File("${_appDocumentsDir.path}/tasks.json");
  }

  saveTasks(List<dynamic> list) async {
    await _tasksFile.writeAsString(jsonEncode(list));
  }

  Future<List<dynamic>> loadTasks() async {
    if (!await _tasksFile.exists()) return [];
    final String encodedList = await _tasksFile.readAsString();
    final List<dynamic> tasks = jsonDecode(encodedList);
    return tasks;
  }
}
