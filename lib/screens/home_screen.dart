import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task_screen.dart';
import 'package:tasky/widgets/high_priority_tasks_widget.dart';
import 'package:tasky/widgets/sliver_task_list_widget.dart';

import '../core/services/preferences_manager.dart';
import '../widgets/achieved_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? userImage;
  List<TaskModel> tasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percentage = 0;

  @override
  void initState() {
    super.initState();
    _getName();
    _loadTasks();
  }

  void _loadTasks() async {
    final encodedTask = PreferencesManager().getString("tasks");
    if (encodedTask != null) {
      final taskAfterDecode = jsonDecode(encodedTask) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calculatePercentage();
      });
    }
  }

  void _deleteTask(int id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _calculatePercentage();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
    print(id);
  }

  void _getName() async {
    setState(() {
      name = PreferencesManager().getString("name");
      userImage = PreferencesManager().getString("user_image");
    });
  }

  _calculatePercentage() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    percentage = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = !tasks[index].isDone;
      _calculatePercentage();
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: userImage == null
                            ? AssetImage("assets/images/person.png")
                            : FileImage(File(userImage!)),
                      ),

                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Evening ,$name ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "One task at a time.One step closer.",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
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
                      SizedBox(width: 8),
                      SvgPicture.asset(
                        "assets/images/waving_hand.svg",
                        width: 32,
                        height: 32,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTasks(
                    totalDoneTasks: totalDoneTasks,
                    totalTasks: totalTasks,
                    percentage: percentage,
                  ),
                  SizedBox(height: 8),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) async {
                      _doneTask(value, index);
                    },
                    refresh: () {
                      _loadTasks();
                    },
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
            SliverTaskListWidget(
              tasks: tasks,
              onTap: (bool? value, int? index) {
                _doneTask(value, index);
              },
              onDelete: (int id) => _deleteTask(id),
              onEdit: () => _loadTasks(),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 170,
        height: 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddTaskScreen()));

            if (result != null && result) {
              _loadTasks();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          label: Text("Add New Task"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
