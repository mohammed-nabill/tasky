import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/features/home/home_controller.dart';

import '../../../models/task_model.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key, this.emptyMassage});

  final String? emptyMassage;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            final List<TaskModel> tasks = controller.tasks;
            return tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        emptyMassage ?? "No Data",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.only(bottom: 60),
                    sliver: SliverList.separated(
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskItemWidget(
                          model: tasks[index],
                          onChanged: (bool? value) =>
                              controller.doneTask(value, index),
                          onDelete: (int id) => controller.deleteTask(id),
                          onEdit: () => controller.loadTasks(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  );
          },
    );
  }
}
