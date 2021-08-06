import 'package:flutter/material.dart';

class Tasks with ChangeNotifier {
  List allTasksList = [];
  List completedTasksList = [];
  List unCompletedTasksList = [];

  void setNewTask(String taskName, bool typeTask) {
    this.allTasksList.add(taskName);
    if (typeTask) {
      this.completedTasksList.add(taskName);
    } else if (!typeTask) {
      this.unCompletedTasksList.add(taskName);
    }
    notifyListeners();
  }

  List getTasks() {
    notifyListeners();

    return this.allTasksList;
  }

  List getCompletedTasks() {
    notifyListeners();

    return this.completedTasksList;
  }

  List getUnCompletedTasks() {
    notifyListeners();

    return this.unCompletedTasksList;
  }
}
