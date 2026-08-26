import 'package:flutter/material.dart';
import 'package:tasky/core/components/task_item_widget.dart';

import '../../models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMassage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String? emptyMassage;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMassage ?? "No Data",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(bottom: 60),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(
                model: tasks[index],
                onChanged: (bool? value) => onTap(value, index),
                onDelete: (int id) => onDelete(id),
                onEdit: () => onEdit(),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
