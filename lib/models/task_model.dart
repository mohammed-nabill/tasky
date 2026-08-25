class TaskModel {
  final int id;
  final String taskName;
  final String taskDescription;
  final bool highPriority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.highPriority,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      taskName: json["taskName"],
      taskDescription: json["taskDescription"],
      highPriority: json["highPriority"],
      isDone: json["isDone"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "highPriority": highPriority,
      "isDone": isDone,
    };
  }
}
