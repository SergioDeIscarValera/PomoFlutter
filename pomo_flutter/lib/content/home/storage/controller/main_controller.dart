import 'dart:async';
import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_comment.dart';
import 'package:PomoFlutter/content/home/services/task_repository.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
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

  final TextEditingController _commentController = TextEditingController();

  final Rx<Task?> taskSelected = Rx<Task?>(null);

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

          // If all tasks are done, go to Get.toNamed(Routes.CONGRATULATIONS.path);
          if (totalTasks.values.every((element) => element.isFinished)) {
            Get.toNamed(Routes.CONGRATULATIONS.path);
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

  void deleteTask(Task task) {
    Get.defaultDialog(
      title: 'delete_task'.tr,
      middleText: 'delete_task_message'.tr,
      textConfirm: "confirm".tr,
      textCancel: "cancel".tr,
      titleStyle: MyTextStyles.h2.textStyle.copyWith(
        color: MyColors.CONTRARY.color,
      ),
      middleTextStyle: MyTextStyles.p.textStyle,
      cancelTextColor: MyColors.CONTRARY.color,
      confirmTextColor: MyColors.DANGER.color,
      backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
      buttonColor: MyColors.CURRENT.color,
      onConfirm: () {
        _deleteTask(task);
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void _deleteTask(Task task) {
    _taskRepository.delete(
        entity: task, idc: authController.firebaseUser!.email!);
  }

  void addComment(Rx<Task?> task) {
    //Show dialog to add comment
    Get.defaultDialog(
      title: 'add_comment'.tr,
      middleText: 'add_comment_message'.tr,
      textConfirm: "confirm".tr,
      textCancel: "cancel".tr,
      titleStyle: MyTextStyles.h2.textStyle.copyWith(
        color: MyColors.CONTRARY.color,
      ),
      middleTextStyle: MyTextStyles.p.textStyle,
      cancelTextColor: MyColors.CONTRARY.color,
      confirmTextColor: MyColors.CONTRARY.color,
      backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
      buttonColor: MyColors.CURRENT.color,
      content: Column(
        children: [
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'comment'.tr,
              hintStyle: MyTextStyles.p.textStyle.copyWith(
                color: MyColors.CONTRARY.color,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MyColors.CONTRARY.color,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MyColors.CURRENT.color,
                ),
              ),
            ),
            style: MyTextStyles.p.textStyle.copyWith(
              color: MyColors.CONTRARY.color,
            ),
          ),
        ],
      ),
      onConfirm: () {
        _addComment(task.value!);
        task.refresh();
        _commentController.clear();
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void _addComment(Task task) {
    final comment = TaskComment(
      content: _commentController.text,
      userPhotoUrl: authController.firebaseUser?.photoURL,
      userName: authController.firebaseUser!.displayName ??
          authController.firebaseUser!.email!.split('@')[0],
    );

    task.addComment(comment);
    _taskRepository.save(
        entity: task, idc: authController.firebaseUser!.email!);
  }

  void deleteComment(Rx<Task?> taskSelected, TaskComment comment) {
    Get.defaultDialog(
      title: 'delete_comment'.tr,
      middleText: 'delete_comment_message'.tr,
      textConfirm: "confirm".tr,
      textCancel: "cancel".tr,
      titleStyle: MyTextStyles.h2.textStyle.copyWith(
        color: MyColors.CONTRARY.color,
      ),
      middleTextStyle: MyTextStyles.p.textStyle,
      cancelTextColor: MyColors.CONTRARY.color,
      confirmTextColor: MyColors.DANGER.color,
      backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
      buttonColor: MyColors.CURRENT.color,
      onConfirm: () {
        _deleteComment(taskSelected.value!, comment);
        taskSelected.refresh();
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void _deleteComment(Task task, TaskComment comment) {
    task.removeComment(comment);
    _taskRepository.save(
        entity: task, idc: authController.firebaseUser!.email!);
  }

  void addPageIndexListener(Function(int) listener) {
    _mainPageController.addListener(() {
      listener(_mainPageController.page!.round());
    });
  }

  void editTask(Task task) {
    Get.defaultDialog(
      title: 'edit_task'.tr,
      textConfirm: "confirm".tr,
      textCancel: "cancel".tr,
      titleStyle: MyTextStyles.h2.textStyle.copyWith(
        color: MyColors.CONTRARY.color,
      ),
      cancelTextColor: MyColors.CONTRARY.color,
      confirmTextColor: MyColors.CONTRARY.color,
      backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
      buttonColor: MyColors.CURRENT.color,
      content: Column(
        children: [
          Text(
            "edit_task_message".tr,
            style: MyTextStyles.p.textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "edit_task_submessage".tr,
            style: MyTextStyles.p.textStyle.copyWith(
              fontSize: 12,
              color: MyColors.CONTRARY.color.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      onConfirm: () {
        taskSelected.value = task;
        _mainPageController.jumpToPage(2);
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
