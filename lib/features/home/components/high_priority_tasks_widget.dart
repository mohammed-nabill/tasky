import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/tasks/high_priority_screen.dart';
import 'package:tasky/models/task_model.dart';

import '../../../core/constants/app_sizes.dart';
import '../../tasks/controller/tasks_controller.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
            final List<TaskModel> tasks = controller.tasks;
            return Container(
              width: double.infinity,
              height: AppSizes.h175,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSizes.r20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppSizes.h8,
                            left: AppSizes.w16,
                            bottom: AppSizes.h8,
                          ),
                          child: Text(
                            "High Priority Tasks",
                            style: TextStyle(
                              color: Color(0xFF15B86C),
                              fontSize: AppSizes.sp14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              tasks.where((e) => e.highPriority).length > 4
                              ? 4
                              : tasks.where((e) => e.highPriority).length,
                          itemBuilder: (context, index) {
                            final task = tasks.reversed
                                .where((e) => e.highPriority)
                                .toList()[index];
                            return Padding(
                              padding: EdgeInsets.only(left: AppSizes.w5),
                              child: Row(
                                children: [
                                  Checkbox(
                                    visualDensity: const VisualDensity(
                                      vertical: -4,
                                      horizontal: -3,
                                    ),
                                    value: task.isDone,
                                    onChanged: (bool? value) {
                                      controller.doneTask(value, task.id);
                                    },
                                    activeColor: Color(0XFF15B86C),
                                  ),
                                  Expanded(
                                    child: Text(
                                      task.taskName,
                                      style: task.isDone
                                          ? Theme.of(
                                              context,
                                            ).textTheme.titleMedium
                                          : Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HighPriorityScreen(),
                        ),
                      );
                      controller.init();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.w16),
                      child: Container(
                        padding: EdgeInsets.all(AppSizes.w8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ThemeController.isDark()
                                ? Color(0xFF6E6E6E)
                                : Color(0xFFD1DAD6),
                          ),
                        ),
                        child: SvgPicture.asset(
                          "assets/images/arrow-up-right.svg",
                          width: AppSizes.w24,
                          height: AppSizes.h24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.tertiary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}
