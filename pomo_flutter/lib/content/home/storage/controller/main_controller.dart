import 'dart:async';
import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/services/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final PageController _mainPageController = PageController();
  PageController get mainPageController => _mainPageController;
  final RxInt _pageIndex = 0.obs;
  RxInt get pageIndex => _pageIndex;

  final RxMap<String, Task> totalTasks = <String, Task>{}.obs;

  final AuthController authController = Get.find();
  final TaskRepository _taskRepository = TaskRepository();

  final Rx<DateTime> now = DateTime.now().obs;

  @override
  void onInit() async {
    _startTimer();
    _mainPageController.addListener(() {
      _pageIndex.value = _mainPageController.page!.round();
    });

    authController.user.listen((user) async {
      if (user == null || user.email == null) return;
      _taskRepository.addListener(
        idc: user.email!,
        listener: (newTasks) {
          totalTasks.clear();
          for (var task in newTasks) {
            totalTasks[task.id] = task;
          }
        },
      );
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
}
