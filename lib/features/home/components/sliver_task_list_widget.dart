import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item_widget.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../models/task_model.dart';
import '../../tasks/controller/tasks_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key, this.emptyMassage});

  final String? emptyMassage;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
            final List<TaskModel> tasks = controller.tasks;
            return tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        emptyMassage ?? "No Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.sp24,
                        ),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.only(bottom: AppSizes.h60),
                    sliver: SliverList.separated(
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskItemWidget(
                          model: tasks[index],
                          onChanged: (bool? value) =>
                              controller.doneTask(value, tasks[index].id),
                          onDelete: (int id) => controller.deleteTask(id),
                          onEdit: () => controller.init(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: AppSizes.h8);
                      },
                    ),
                  );
          },
    );
  }
}
