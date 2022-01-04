import 'dart:collection';

import 'package:flutter/material.dart';

import 'task.dart';

enum TaskFilter { all, active, completed }

class Tasks extends ChangeNotifier {
  final List<Task> _taskList = [];

  var _taskFilter = TaskFilter.all;

  void setTaskFilter(TaskFilter taskFilter) {
    _taskFilter = taskFilter;
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    switch (_taskFilter) {
      case TaskFilter.completed:
        return UnmodifiableListView(
            _taskList.where((element) => element.isCompleted));
      case TaskFilter.active:
        return UnmodifiableListView(
            _taskList.where((element) => !element.isCompleted));
      case TaskFilter.all:
      default:
        return UnmodifiableListView(_taskList);
    }
  }

  int get tasksToComplete => _taskList.where((element) => !element.isCompleted).length;

  void addTask(Task task) {
    _taskList.add(task);
    notifyListeners();
  }

  void setCompleteTask(Task task, bool isCompleted) {
    task.isCompleted = isCompleted;
    notifyListeners();
  }
}
