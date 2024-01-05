import 'package:PomoFlutter/content/home/models/task.dart';
import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendaryController extends GetxController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxList<DateTime> weekDays = <DateTime>[].obs;

  final RxMap<String, Task> selectedDayTasks = <String, Task>{}.obs;

  //final AuthController authController = Get.find();
  final MainController mainController = Get.find();

  @override
  void onInit() {
    weekDays.value = _getWeekDays();
    _filterList(tasks: mainController.totalTasks.values.toList());
    selectedDate.listen((event) {
      weekDays.value = _getWeekDays();
      _filterList(tasks: mainController.totalTasks.values.toList());
    });
    mainController.totalTasks.listen((event) {
      _filterList(tasks: event.values.toList());
    });
    super.onInit();
  }

  List<DateTime> _getWeekDays() {
    //Semana de 7 dias tomando el dia seleccionado como el dia central
    List<DateTime> weekDays = [];
    DateTime date = selectedDate.value.subtract(const Duration(days: 3));
    for (int i = 0; i < 7; i++) {
      weekDays.add(date.add(Duration(days: i)));
    }
    return weekDays;
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void changeMonth(int i) {
    selectedDate.value = selectedDate.value.add(Duration(days: i * 30));
  }

  void openDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        selectedDate.value = value;
      }
    });
  }

  bool _isSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  void _filterList({required List<Task> tasks}) {
    selectedDayTasks.clear();
    var taskFiltered = tasks
        .where((element) =>
            _isSameDay(element.dateTime, selectedDate.value) ||
            (element.dateTime.isBefore(selectedDate.value) &&
                element.endDateTime.isAfter(selectedDate.value)) ||
            _isSameDay(element.endDateTime, selectedDate.value))
        .toList();
    // Sort tasks by dateTime
    for (var task in taskFiltered
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime))) {
      selectedDayTasks[task.id] = task;
    }
  }

  /*void _filterList() async {
    var tasks = await TaskRepository().findAllByDay(
      dateTime: selectedDate.value,
      idc: mainController.authController.firebaseUser!.email!,
    );
    selectedDayTasks.clear();
    // Sort tasks by dateTime
    for (var task in tasks..sort((a, b) => a.dateTime.compareTo(b.dateTime))) {
      selectedDayTasks[task.id] = task;
    }
  }*/

  void resetSelectedDate() {
    selectedDate.value = DateTime.now();
  }
}
