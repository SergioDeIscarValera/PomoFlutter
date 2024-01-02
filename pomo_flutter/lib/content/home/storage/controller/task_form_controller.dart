import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/task_colors.dart';
import 'package:PomoFlutter/content/home/services/task_repository.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/utils/storage_keys.dart';
import 'package:PomoFlutter/utils/snakbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TaskFormController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<DateTime> selectedTime = DateTime.now().obs; // TimeOfDay
  DateTime get selectedDateTime => DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        selectedTime.value.hour,
        selectedTime.value.minute,
      );

  final RxBool isManualEndDate = false.obs;
  final Rx<DateTime> selectedDateEnd = DateTime.now().obs;
  final Rx<DateTime> selectedTimeEnd = DateTime.now().obs; // TimeOfDay
  DateTime get selectedDateTimeEnd => DateTime(
        selectedDateEnd.value.year,
        selectedDateEnd.value.month,
        selectedDateEnd.value.day,
        selectedTimeEnd.value.hour,
        selectedTimeEnd.value.minute,
      );

  Rx<TaskCategory> selectedCategory = TaskCategory.values[0].obs;
  Rx<TaskColor> selectedColor = TaskColor.values[0].obs;

  final RxInt countWorkingSession = 1.obs;
  final RxInt timeWorkingSession = 25.obs;
  final RxInt timeBreakSession = 5.obs;
  final RxInt timeLongBreakSession = 15.obs;

  final RxBool saveInDeviceCalendar = false.obs;

  final TaskRepository _taskRepository = TaskRepository();
  final AuthController authController = Get.find();
  final MainController mainController = Get.find();

  @override
  void onInit() {
    resetForm();
    selectedDate.listen((value) {
      if (value.isAfter(selectedDateEnd.value) || !isManualEndDate.value) {
        selectedDateEnd.value = value;
      }
      // Al cambiar el dia tambien hay que comprobar la hora
      if (value.day == selectedDateEnd.value.day &&
          value.month == selectedDateEnd.value.month &&
          value.year == selectedDateEnd.value.year) {
        selectedTimeEnd.value = selectedTime.value;
      }
    });
    selectedTime.listen((value) {
      if (value.isAfter(selectedTimeEnd.value) || !isManualEndDate.value) {
        selectedTimeEnd.value = value;
      }
    });

    selectedDateEnd.listen((value) {
      if (value.day == selectedDate.value.day &&
          value.month == selectedDate.value.month &&
          value.year == selectedDate.value.year) {
        selectedTimeEnd.value = selectedTime.value;
      }
    });
    super.onInit();
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();

    selectedDate.value = DateTime.now();
    selectedTime.value = DateTime.now();

    selectedCategory.value = TaskCategory.values[0];
    selectedColor.value = TaskColor.values[0];

    saveInDeviceCalendar.value = false;

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

  void selectDate({
    required BuildContext context,
    required Rx<DateTime> date,
    DateTime? firstDate,
  }) {
    showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        date.value = value;
      }
    });
  }

  void selectTime({
    required BuildContext context,
    required Rx<DateTime> time,
    required DateTime dayBase,
    DateTime? limitTime,
  }) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(time.value),
    ).then((value) {
      if (value != null) {
        var newValue = DateTime(
          dayBase.year,
          dayBase.month,
          dayBase.day,
          value.hour,
          value.minute,
        );

        if (limitTime != null && newValue.isBefore(limitTime)) {
          newValue = limitTime;
          MySnackBar.snackError("task_form_error_time".tr);
        }

        time.value = newValue;
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
      dateTime: selectedDateTime,
      category: selectedCategory.value,
      color: selectedColor.value,
      workSessions: countWorkingSession.value,
      workSessionTime: timeWorkingSession.value,
      longBreakTime: timeLongBreakSession.value,
      shortBreakTime: timeBreakSession.value,
      endDateTime: isManualEndDate.value
          ? DateTime(
              selectedDateEnd.value.year,
              selectedDateEnd.value.month,
              selectedDateEnd.value.day,
              selectedTimeEnd.value.hour,
              selectedTimeEnd.value.minute,
            )
          : null,
    );

    if (authController.firebaseUser == null ||
        authController.firebaseUser!.email == null) return;

    late Task? result;
    if (saveInDeviceCalendar.value) {
      result = await _taskRepository.saveWithDeviceCalendar(
        entity: newTask,
        idc: authController.firebaseUser!.email!,
      );
    } else {
      result = await _taskRepository.save(
        entity: newTask,
        idc: authController.firebaseUser!.email!,
      );
    }
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
