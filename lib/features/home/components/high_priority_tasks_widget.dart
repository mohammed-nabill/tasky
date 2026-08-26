import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/tasks/high_priority_screen.dart';
import 'package:tasky/models/task_model.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 175,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
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
                  padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
                  child: Text(
                    "High Priority Tasks",
                    style: TextStyle(
                      color: Color(0xFF15B86C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tasks.where((e) => e.highPriority).length > 4
                      ? 4
                      : tasks.where((e) => e.highPriority).length,
                  itemBuilder: (context, index) {
                    final task = tasks.reversed
                        .where((e) => e.highPriority)
                        .toList()[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: [
                          Checkbox(
                            visualDensity: const VisualDensity(
                              vertical: -4,
                              horizontal: -3,
                            ),
                            value: task.isDone,
                            onChanged: (bool? value) {
                              final index = tasks.indexWhere(
                                (e) => e.id == task.id,
                              );
                              onTap(value, index);
                            },
                            activeColor: Color(0XFF15B86C),
                          ),
                          Expanded(
                            child: Text(
                              task.taskName,
                              style: task.isDone
                                  ? Theme.of(context).textTheme.titleMedium
                                  : Theme.of(context).textTheme.bodyMedium,
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
                MaterialPageRoute(builder: (context) => HighPriorityScreen()),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(8),
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
                  width: 24,
                  height: 24,
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
  }
}
