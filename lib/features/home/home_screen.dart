import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky/features/home/home_controller.dart';

import '../../core/constants/app_sizes.dart';
import '../tasks/controller/tasks_controller.dart';
import 'components/achieved_task_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController()..init(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: AppSizes.h16),
                    Row(
                      children: [
                        Selector<HomeController, String?>(
                          builder:
                              (
                                BuildContext context,
                                String? userImage,
                                Widget? child,
                              ) {
                                return CircleAvatar(
                                  radius: 24,
                                  backgroundImage: userImage == null
                                      ? AssetImage("assets/images/person.png")
                                      : FileImage(File(userImage)),
                                );
                              },
                          selector:
                              (
                                BuildContext context,
                                HomeController controller,
                              ) => controller.userImage,
                        ),

                        SizedBox(width: AppSizes.w14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector<HomeController, String?>(
                              builder:
                                  (
                                    BuildContext context,
                                    String? name,
                                    Widget? child,
                                  ) {
                                    return Text(
                                      "Good Evening ,$name ",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    );
                                  },
                              selector:
                                  (
                                    BuildContext context,
                                    HomeController controller,
                                  ) => controller.name,
                            ),
                            Text(
                              "One task at a time.One step closer.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
                    Text(
                      "Yuhuu ,Your work Is ",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          "almost done !",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(width: AppSizes.w8),
                        SvgPicture.asset(
                          "assets/images/waving_hand.svg",
                          width: AppSizes.w32,
                          height: AppSizes.h32,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
                    AchievedTasks(),
                    SizedBox(height: AppSizes.h8),
                    HighPriorityTasksWidget(),
                    SizedBox(height: AppSizes.h8),
                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSizes.h24,
                        bottom: AppSizes.h16,
                      ),
                      child: Text(
                        "My Tasks",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SliverTaskListWidget(),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: AppSizes.w170,
          height: AppSizes.h40,
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddTaskScreen()),
                  );

                  if (result != null && result) {
                    context.read<TasksController>().init();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                label: Text("Add New Task"),
                icon: Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}
