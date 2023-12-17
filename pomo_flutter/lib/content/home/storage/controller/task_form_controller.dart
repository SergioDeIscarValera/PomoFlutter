import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:PomoFlutter/content/home/services/task_repository.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TaskFormController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<DateTime> selectedTime = DateTime.now().obs; // TimeOfDay

  Rx<TaskCategory> selectedCategory = TaskCategory.values[0].obs;
  Rx<TaskColor> selectedColor = TaskColor.values[0].obs;

  final RxInt countWorkingSession = 1.obs;
  final RxInt timeWorkingSession = 25.obs;
  final RxInt timeBreakSession = 5.obs;
  final RxInt timeLongBreakSession = 15.obs;

  final TaskRepository _taskRepository = TaskRepository();
  final AuthController authController = Get.find();
  final MainController mainController = Get.find();

  @override
  void onInit() {
    resetForm();
    super.onInit();
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();

    selectedDate.value = DateTime.now();
    selectedTime.value = DateTime.now();

    selectedCategory.value = TaskCategory.values[0];
    selectedColor.value = TaskColor.values[0];

    //Load config from storage if is mobile
    if (GetPlatform.isWeb) {
      _defaultConfig();
    } else {
      _loadFromStorage();
    }
  }

  void _defaultConfig() {
    countWorkingSession.value = 1;
    timeWorkingSession.value = 25;
    timeBreakSession.value = 5;
    timeLongBreakSession.value = 15;
  }

  void _loadFromStorage() {
    final box = GetStorage();
    countWorkingSession.value =
        box.read(StorageKeys().countWorkingSession) ?? 1;
    timeWorkingSession.value = box.read(StorageKeys().timeWorkingSession) ?? 25;
    timeBreakSession.value = box.read(StorageKeys().timeBreakSession) ?? 5;
    timeLongBreakSession.value =
        box.read(StorageKeys().timeLongBreakSession) ?? 15;
  }

  void selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        selectedDate.value = value;
      }
    });
  }

  void selectTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime.value),
    ).then((value) {
      if (value != null) {
        selectedTime.value = DateTime(
          selectedDate.value.year,
          selectedDate.value.month,
          selectedDate.value.day,
          value.hour,
          value.minute,
        );
      }
    });
  }

  void selectCategory(TaskCategory value) {
    selectedCategory.value = value;
  }

  void selectColor(TaskColor value) {
    selectedColor.value = value;
  }

  void saveTask() async {
    var newTask = Task(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      dateTime: DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        selectedTime.value.hour,
        selectedTime.value.minute,
      ),
      category: selectedCategory.value,
      color: selectedColor.value,
      workSessions: countWorkingSession.value,
      workSessionTime: timeWorkingSession.value,
      longBreakTime: timeLongBreakSession.value,
      shortBreakTime: timeBreakSession.value,
    );
    if (authController.firebaseUser == null ||
        authController.firebaseUser!.email == null) return;
    var result = await _taskRepository.save(
        entity: newTask, idc: authController.firebaseUser!.email!);
    if (result == null) return;
    mainController.setPage(0);
    resetForm();
  }

  void setCountWorkingSession(double value) {
    countWorkingSession.value = value.round();
  }

  void setTimeWorkingSession(double value) {
    timeWorkingSession.value = value.round();
  }

  void setTimeBreakSession(double value) {
    timeBreakSession.value = value.round();
  }

  void setTimeLongBreakSession(double value) {
    timeLongBreakSession.value = value.round();
  }
}
