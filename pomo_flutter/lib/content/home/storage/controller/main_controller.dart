import 'dart:async';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final PageController _mainPageController = PageController();
  PageController get mainPageController => _mainPageController;
  final RxInt _pageIndex = 0.obs;
  RxInt get pageIndex => _pageIndex;

  final Rx<DateTime> now = DateTime.now().obs;

  final RxMap<String, Task> todayTasks = <String, Task>{}.obs;
  final Rx<TaskCategory?> categoryFilterSelected = Rx<TaskCategory?>(null);
  final RxList<Task> filteredTask = <Task>[].obs;

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
      _filterTasks();
    });

    filteredTask.value = todayTasks.values.toList();
    categoryFilterSelected.listen((event) {
      _filterTasks();
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
    todayTasks.removeWhere(
        (key, value) => filteredTask.contains(value) && value.isFinished);
    //Por ahora sin DB
    todayTasks.refresh();
  }

  void markAllTasksAsDone() {
    for (var task in todayTasks.values) {
      if (!filteredTask.contains(task)) {
        continue;
      }
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

  void setCategoryFilter(TaskCategory? value) {
    categoryFilterSelected.value = value;
  }

  void _filterTasks() {
    if (categoryFilterSelected.value == null) {
      filteredTask.value = todayTasks.values.toList();
      return;
    }
    filteredTask.value = todayTasks.values
        .where((task) => task.category == categoryFilterSelected.value)
        .toList();
  }
}
