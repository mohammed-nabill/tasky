import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

import '../core/services/preferences_manager.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskName = TextEditingController();

  final TextEditingController _taskDescription = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool highPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                hintText: "Finish UI design for login screen",
                controller: _taskName,
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
                controller: _taskDescription,
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
                  Switch(
                    value: highPriority,
                    onChanged: (onChanged) {
                      highPriority = onChanged;
                      setState(() {});
                    },
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                onPressed: () async {
                  if (_form.currentState!.validate()) {
                    final taskJson = PreferencesManager().getString("tasks");
                    List listTasks = [];
                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }
                    final TaskModel model = TaskModel(
                      id: DateTime.now().millisecondsSinceEpoch,
                      taskName: _taskName.text,
                      taskDescription: _taskDescription.text,
                      highPriority: highPriority,
                    );
                    listTasks.add(model.toJson());

                    final taskEncode = jsonEncode(listTasks);
                    await PreferencesManager().setString("tasks", taskEncode);
                    Navigator.of(context).pop(true);
                  }
                },
                label: Text("Add Task"),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
