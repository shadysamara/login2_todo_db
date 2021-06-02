import 'package:flutter/material.dart';
import 'package:login_todo_database/models/task_model.dart';
import 'package:login_todo_database/repositories/db_repository.dart';

class DbProvider extends ChangeNotifier {
  List<Task> allTasks = [];
  List<Task> completeTasks = [];
  List<Task> inCompleteTasks = [];

  fillLists(List<Task> tasks) {
    allTasks = tasks;
    completeTasks = tasks.where((element) => element.isComplete).toList();
    inCompleteTasks = tasks.where((element) => !element.isComplete).toList();

    notifyListeners();
  }

  getAllTasks() async {
    List<Task> tasks = await DBRepository.dbRepository.getAllData();

    fillLists(tasks);
  }

  insertTask(Task task) async {
    await DBRepository.dbRepository.insertNewTask(task);
    getAllTasks();
  }

  deleteTask(Task task) async {
    await DBRepository.dbRepository.deleteTask(task);
    getAllTasks();
  }

  updateTask(Task task) async {
    await DBRepository.dbRepository.updateTask(task);
    getAllTasks();
  }
}
