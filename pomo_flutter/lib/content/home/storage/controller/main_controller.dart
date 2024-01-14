import 'dart:async';
import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/models/task_invitation.dart';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_comment.dart';
import 'package:PomoFlutter/content/home/services/notification/interface_notication_repository.dart';
import 'package:PomoFlutter/content/home/services/notification/notification_repository.dart';
import 'package:PomoFlutter/content/home/services/task/task_repository.dart';
import 'package:PomoFlutter/routes/app_routes.dart';
import 'package:PomoFlutter/services/id_user/id_user_repository.dart';
import 'package:PomoFlutter/services/id_user/interface_id_user_repository.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/utils/form_validator.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
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
  final IIdUserRepository _idUserRepository = IdUserRepository();
  final INotificationRepository _notificationRepository =
      NotificationRepository();

  final Rx<DateTime> now = DateTime.now().obs;

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _guestEmailController = TextEditingController();

  final Rx<Task?> taskSelected = Rx<Task?>(null);

  final RxList<TaskInvitation> notifications = <TaskInvitation>[].obs;

  final FormValidator formValidator = FormValidator();

  int _lastNotificationCount = 0;
  int _lastCountTasks = 0;
  @override
  void onInit() {
    _startTimer();
    _mainPageController.addListener(() {
      _pageIndex.value = _mainPageController.page!.round();
    });

    authController.user.listen((user) {
      if (user == null || user.email == null) return;
      _taskRepository.addListener(
        idc: user.email!,
        listener: (newTasks) {
          totalTasks.removeWhere((key, value) => value.amIPropietary);
          var allIsFinished = true;
          for (var task in newTasks) {
            totalTasks[task.id] = task;
            if (!task.isFinished) allIsFinished = false;
          }
          // If all tasks are done, go to Get.toNamed(Routes.CONGRATULATIONS.path);
          if (allIsFinished &&
              Get.currentRoute != Routes.CONGRATULATIONS.path &&
              _lastCountTasks > 0) {
            Get.toNamed(Routes.CONGRATULATIONS.path);
          }
          _lastCountTasks = totalTasks.values.map((e) => !e.isFinished).length;
        },
      );
    });

    _notificationRepository.addListener(
      idc: authController.firebaseUser!.email!,
      listener: (newNotifications) {
        notifications.clear();
        notifications.addAll(newNotifications);
        var acceptedNotifications =
            notifications.where((element) => element.state).toList();
        if (notifications.length - acceptedNotifications.length >
            _lastNotificationCount) {
          MySnackBar.snackSuccess('new_task_invitation'.tr);
        }
        _lastNotificationCount = notifications.length;
        _addTasksFromNotifications(acceptedNotifications);
      },
    );

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
    if (!task.amIPropietary) {
      MySnackBar.snackError('you_are_not_the_propietary'.tr);
      return;
    }
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
    );
  }

  void _deleteTask(Task task) {
    _taskRepository.delete(
        entity: task, idc: authController.firebaseUser!.email!);
  }

  void addComment(Rx<Task?> task, Function() onOpen, Function() onClose) {
    //Show dialog to add comment
    onOpen();
    var dialog = Get.defaultDialog(
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
        if (formValidator.isValidComment(_commentController.text) != null) {
          MySnackBar.snackError('comment_error'.tr);
          return;
        }
        _addComment(task.value!);
        task.refresh();
        _commentController.clear();
        Get.back();
      },
      onCancel: () {
        _commentController.clear();
      },
    );

    dialog.then((value) => onClose());
  }

  void _addComment(Task task) {
    final comment = TaskComment(
      content: _commentController.text,
      userPhotoUrl: authController.firebaseUser?.photoURL,
      userName: authController.firebaseUser!.displayName ??
          authController.firebaseUser!.email!.split('@')[0],
    );

    var email = task.amIPropietary
        ? authController.firebaseUser!.email!
        : task.propietaryEmail!;

    task.addComment(comment);
    _taskRepository.save(entity: task, idc: email);
  }

  void deleteComment(Rx<Task?> taskSelected, TaskComment comment) {
    if (comment.userName != authController.firebaseUser!.displayName &&
        !taskSelected.value!.amIPropietary) {
      MySnackBar.snackError('you_are_not_the_propietary'.tr);
      return;
    }
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
    if (!task.amIPropietary) {
      MySnackBar.snackError('you_are_not_the_propietary'.tr);
      return;
    }
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
    );
  }

  void addGuest(Rx<Task?> taskSelected, Function() onOpen, Function() onClose) {
    //Show dialog to add guest (IdUser)
    onOpen();
    var dialog = Get.defaultDialog(
        title: 'add_guest'.tr,
        middleText: 'add_guest_message'.tr,
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
              controller: _guestEmailController,
              decoration: InputDecoration(
                hintText: 'guest_email'.tr,
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
        onConfirm: () async {
          var guestEmail = _guestEmailController.text.trim();
          if (formValidator.isValidEmail(guestEmail) != null ||
              guestEmail == authController.firebaseUser!.email!) {
            MySnackBar.snackError('email_error'.tr);
            return;
          }
          bool? result = await _addGuest(taskSelected.value!, guestEmail);
          taskSelected.refresh();
          _guestEmailController.clear();
          Get.back();
          switch (result) {
            case null:
              MySnackBar.snackWarning('guest_already_added'.tr);
              break;
            case true:
              MySnackBar.snackSuccess('guest_added'.tr);
              break;
            case false:
              MySnackBar.snackError('guest_not_added'.tr);
              break;
          }
        },
        onCancel: () {
          _guestEmailController.clear();
        });

    dialog.then((value) => onClose());
  }

  Future<bool?> _addGuest(Task task, String guestEmail) async {
    if (!await _idUserRepository.existEmail(email: guestEmail)) {
      MySnackBar.snackError('guest_not_exist'.tr);
      return false;
    }
    var notification = TaskInvitation(
      taskIdTrasmitter: task.id,
      transmitterEmail: authController.firebaseUser!.email!,
      taskTitle: task.title,
      dateTime: now.value,
    );
    if (await _notificationRepository.existsById(
        id: notification.id, idc: guestEmail)) {
      return null;
    }

    var result = await _notificationRepository.save(
      entity: notification,
      idc: guestEmail,
    );

    return result != null;
  }

  void acceptTaskInvitation(TaskInvitation notification) async {
    var task = await _taskRepository.findById(
      id: notification.taskIdTrasmitter,
      idc: notification.transmitterEmail,
    );
    if (task == null) {
      _deleteTaskInvitation(notification);
      MySnackBar.snackError('task_not_exist'.tr);
      return;
    }
    task.guests.add(authController.firebaseUser!.email!);
    var taskResult = await _taskRepository.save(
        entity: task, idc: notification.transmitterEmail);

    if (taskResult == null) {
      _deleteTaskInvitation(notification);
      MySnackBar.snackError('task_not_exist'.tr);
      return;
    }

    notification.state = true;
    var result = await _notificationRepository.save(
      entity: notification,
      idc: authController.firebaseUser!.email!,
    );

    if (result == null) {
      _deleteTaskInvitation(notification);
      MySnackBar.snackError('notification_error_saving'.tr);
      return;
    }

    MySnackBar.snackSuccess('task_accepted'.tr);
  }

  void declineTaskInvitation(TaskInvitation notification) {
    //Show dialog to decline task invitation
    Get.defaultDialog(
      title: 'decline_task_invitation'.tr,
      middleText: 'decline_task_invitation_message'.tr,
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
        _deleteTaskInvitation(notification);
        Get.back();
      },
    );
  }

  void _deleteTaskInvitation(TaskInvitation notification) async {
    var task = await _taskRepository.findById(
      id: notification.taskIdTrasmitter,
      idc: notification.transmitterEmail,
    );

    if (task != null) {
      task.guests.remove(authController.firebaseUser!.email!);
      await _taskRepository.save(
        entity: task,
        idc: notification.transmitterEmail,
      );
    }

    _notificationRepository.delete(
      entity: notification,
      idc: authController.firebaseUser!.email!,
    );
  }

  void _addTasksFromNotifications(
    List<TaskInvitation> acceptedNotifications,
  ) async {
    var tasksFutures = acceptedNotifications.map(
      (noti) => _taskRepository.findById(
        id: noti.taskIdTrasmitter,
        idc: noti.transmitterEmail,
      ),
    );

    List<Task?> tasks = await Future.wait(tasksFutures);

    //remove notifications failed from database
    var notificationsToDelete = acceptedNotifications
        .where((element) =>
            !tasks.any((task) => task?.id == element.taskIdTrasmitter))
        .toList();
    for (var notification in notificationsToDelete) {
      _deleteTaskInvitation(notification);
    }

    totalTasks.removeWhere((key, value) => !value.amIPropietary);
    for (var task in tasks) {
      if (task == null) continue;
      task.amIPropietary = false;
      task.propietaryEmail = acceptedNotifications
          .firstWhere((element) => element.taskIdTrasmitter == task.id)
          .transmitterEmail;
      totalTasks[task.id] = task;
    }
  }

  void removeGuest({Task? task, required String guest}) async {
    if (task == null || !task.amIPropietary) return;
    //Remove notification from guest
    var id = "${authController.firebaseUser!.email!}___${task.id}";
    await _notificationRepository.deleteById(id: id, idc: guest);

    //Remove guest from task
    task.guests.remove(guest);
    await _taskRepository.save(
      entity: task,
      idc: authController.firebaseUser!.email!,
    );
  }
}
