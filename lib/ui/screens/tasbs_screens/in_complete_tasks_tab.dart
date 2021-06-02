import 'package:flutter/material.dart';
import 'package:login_todo_database/providers/db_provider.dart';
import 'package:login_todo_database/ui/widgets/task_item.dart';
import 'package:provider/provider.dart';

class InCompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<DbProvider>(builder: (context, provider, y) {
      return ListView.builder(
          itemCount: provider.inCompleteTasks.length,
          itemBuilder: (context, index) {
            return TaskItem(provider.inCompleteTasks[index]);
          });
    });
  }
}
