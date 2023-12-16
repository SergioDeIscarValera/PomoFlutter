import 'dart:async';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final PageController _mainPageController = PageController();
  PageController get mainPageController => _mainPageController;
  final RxInt _pageIndex = 0.obs;
  RxInt get pageIndex => _pageIndex;

  final Rx<DateTime> now = DateTime.now().obs;

  final RxMap<String, Task> todayTasks = {
    "1": Task(
      id: "1",
      title: "Task1",
      description: "Des1",
      dateTime: DateTime.now(),
      category: TaskCategory.personal,
      color: TaskColors.blue,
      workSessions: 8,
      workSessionTime: 25,
      longBreakTime: 15,
      shortBreakTime: 5,
      workSessionsCompleted: 3,
    ),
    "2": Task(
      id: "2",
      title: "Task2",
      description: "Des2",
      dateTime: DateTime.now(),
      category: TaskCategory.shopping,
      color: TaskColors.red,
      workSessions: 8,
      workSessionTime: 25,
      longBreakTime: 15,
      shortBreakTime: 5,
      workSessionsCompleted: 8,
    ),
    "3": Task(
      id: "3",
      title: "Task3",
      description: "Des3",
      dateTime: DateTime.now(),
      category: TaskCategory.work,
      color: TaskColors.green,
      workSessions: 8,
      workSessionTime: 25,
      longBreakTime: 15,
      shortBreakTime: 5,
    ),
    "4": Task(
      id: "4",
      title: "Task4",
      description: "Des4",
      dateTime: DateTime.now(),
      category: TaskCategory.others,
      color: TaskColors.yellow,
      workSessions: 8,
      workSessionTime: 25,
      longBreakTime: 15,
      shortBreakTime: 5,
      workSessionsCompleted: 8,
    ),
    "5": Task(
      id: "5",
      title: "Task5",
      description: "Des5",
      dateTime: DateTime.now(),
      category: TaskCategory.personal,
      color: TaskColors.purple,
      workSessions: 8,
      workSessionTime: 25,
      longBreakTime: 15,
      shortBreakTime: 5,
      workSessionsCompleted: 6,
    ),
    "6": Task(
      id: "6",
      title: "Task6",
      description: "Des6",
      dateTime: DateTime.now(),
      category: TaskCategory.shopping,
      color: TaskColors.red,
      workSessions: 8,
      workSessionTime: 25,
      longBreakTime: 15,
      shortBreakTime: 5,
    ),
  }.obs;
  //final RxMap<String, Task> todayTasks = <String, Task>{}.obs;

  final RxDouble _taskProgress = 0.0.obs;
  RxDouble get taskProgress => _taskProgress;

  @override
  void onInit() async {
    _startTimer();
    _mainPageController.addListener(() {
      _pageIndex.value = _mainPageController.page!.round();
    });

    _taskProgress.value = _getFinishedPercentage(todayTasks);
    todayTasks.listen((event) {
      _taskProgress.value = _getFinishedPercentage(event);
    });

    super.onInit();
  }

  void setPage(int index) {
    /*_mainPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );*/
    _mainPageController.jumpToPage(index);
  }

  void _startTimer() {
    Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        now.value = DateTime.now();
      },
    );
  }

  void clickTaskPlay(String id) {
    if (todayTasks[id]!.isFinished) {
      removeTask(id);
    } else {
      addWorkSession(id);
    }
  }

  void addWorkSession(String id) {
    todayTasks[id]!.addWorkSession();
    //Por ahora sin DB
    todayTasks.refresh();
  }

  void removeTask(String id) {
    todayTasks.remove(id);
    //Por ahora sin DB
    todayTasks.refresh();
  }

  void clearDoneTasks() {
    todayTasks.removeWhere((key, value) => value.isFinished);
    //Por ahora sin DB
    todayTasks.refresh();
  }

  void markAllTasksAsDone() {
    for (var task in todayTasks.values) {
      task.setAsDone();
    }
    //Por ahora sin DB
    todayTasks.refresh();
  }

  double _getFinishedPercentage(Map<String, Task> map) {
    if (map.isEmpty) {
      return 0;
    }
    return map.values.where((task) => task.isFinished).length /
        map.length *
        100;
  }
}
