import 'package:flutter/material.dart';
import 'package:login_todo_database/models/task_model.dart';
import 'package:login_todo_database/providers/db_provider.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  Task task;
  TaskItem(this.task);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dismissible(
      key: ObjectKey(task),
      onDismissed: (direction) {
        Provider.of<DbProvider>(context, listen: false).deleteTask(task);
      },
      child: Card(
        child: ListTile(
          title: Text(task.title),
          trailing: Checkbox(
            value: task.isComplete,
            onChanged: (value) {
              Provider.of<DbProvider>(context, listen: false).updateTask(task);
            },
          ),
        ),
      ),
    );
  }
}
