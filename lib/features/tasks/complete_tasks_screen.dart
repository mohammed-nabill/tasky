import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/tasks_controller.dart';

import '../../core/components/task_list_widget.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final TasksController controller = context.read<TasksController>();
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
                child: Consumer<TasksController>(
                  builder: (BuildContext context, TasksController value, _) {
                    return TaskListWidget(
                      emptyMassage: "No Task Found",
                      tasks: value.completeTasks,
                      onTap: (bool? value, int? index) {
                        controller.doneCompleteTask(value, index);
                      },
                      onDelete: (int id) => controller.deleteTask(id),
                      onEdit: () => controller.init(),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
