import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/add_task/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (BuildContext context) => AddTaskController(),
      builder: (context, _) {
        AddTaskController controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: controller.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    hintText: "Finish UI design for login screen",
                    controller: controller.taskName,
                    title: "Task Name",
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your task name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    hintText:
                        "Finish onboarding UI and hand off to\ndevs by Thursday.",
                    controller: controller.taskDescription,
                    title: "Task Description",
                    maxLines: 5,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "High Priority",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Consumer<AddTaskController>(
                        builder:
                            (
                              BuildContext context,
                              AddTaskController value,
                              Widget? _,
                            ) {
                              return Switch(
                                value: value.highPriority,
                                onChanged: (value) {
                                  controller.toggle(value);
                                },
                              );
                            },
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    onPressed: () {
                      controller.addTask(context);
                    },
                    label: Text("Add Task"),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
