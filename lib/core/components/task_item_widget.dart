import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

import '../enums/task_item_actions_enum.dart';
import '../services/preferences_manager.dart';
import '../theme/theme_controller.dart';
import '../widgets/custom_checkbox.dart';
import '../widgets/custom_text_form_field.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;

  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          CustomCheckbox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: model.isDone
                      ? Theme.of(context).textTheme.titleMedium
                      : Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                ),

                if (model.taskDescription.trim().isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFC6C6C6),
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0xFFA0A0A0) : Color(0xFFC6C6C6))
                  : (model.isDone ? Color(0xFF6A6A6A) : Color(0xFF3A4640)),
            ),

            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
                case TaskItemActionsEnum.edit:
                  final result = await _buildShowModalBottomSheet(
                    context,
                    model,
                  );
                  if (result == true) {
                    onEdit();
                  }
                case TaskItemActionsEnum.delete:
                  _buildShowDialog(context);
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values
                .map((e) => PopupMenuItem(value: e, child: Text(e.name)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Future<bool?> _buildShowModalBottomSheet(
    BuildContext context,
    TaskModel model,
  ) {
    final GlobalKey<FormState> form = GlobalKey<FormState>();
    final TextEditingController taskName = TextEditingController(
      text: model.taskName,
    );
    final TextEditingController taskDescription = TextEditingController(
      text: model.taskDescription,
    );
    bool highPriority = model.highPriority;

    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                CustomTextFormField(
                  hintText: "Finish UI design for login screen",
                  controller: taskName,
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
                  controller: taskDescription,
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
                    if (form.currentState!.validate()) {
                      final taskJson = PreferencesManager().getString("tasks");
                      List listTasks = [];
                      if (taskJson != null) {
                        listTasks = jsonDecode(taskJson);
                      }
                      final TaskModel newModel = TaskModel(
                        id: model.id,
                        taskName: taskName.text,
                        taskDescription: taskDescription.text,
                        highPriority: highPriority,
                        isDone: model.isDone,
                      );
                      final int index = listTasks.indexWhere(
                        (element) => element['id'] == model.id,
                      );
                      listTasks[index] = newModel;
                      final taskEncode = jsonEncode(listTasks);
                      await PreferencesManager().setString("tasks", taskEncode);
                      Navigator.of(context).pop(true);
                    }
                  },
                  label: Text("Edit Task"),
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure you want to delete this task"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onDelete(model.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }
}
